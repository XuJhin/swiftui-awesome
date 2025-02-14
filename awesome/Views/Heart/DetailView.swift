//
//  DetailView.swift
//  awesome
//
//  Created by dingstock on 2025/2/14.
//

import Foundation
import HealthKit
import SwiftUI

struct DetailView: View {
    var data: ActivityData
    @State private var hike: Hike? = nil
    @State private var dataToShow = \Hike.Observation.heartRate
    var buttons = [
        ("Elevation", \Hike.Observation.elevation),
        ("Heart Rate", \Hike.Observation.heartRate),
        ("Pace", \Hike.Observation.pace)
    ]
    var body: some View {
        VStack {
            if let hike = hike {
                HikeGraph(hike: hike, path: dataToShow)
                    .frame(height: 100)
                    .padding()
            }
            HStack(spacing: 25) {
                ForEach(buttons, id: \.0) { value in
                    Button {
                        dataToShow = value.1
                    } label: {
                        Text(value.0)
                            .font(.system(size: 15))
                            .foregroundStyle(value.1 == dataToShow
                                ? .gray
                                : .accentColor)
                            .animation(nil)
                    }
                }
            }
            Button("加载心率数据") {
                fetchHeartRate()
            }
        }
        .onAppear {
            fetchHeartRate()
        }
    }

    private func fetchHeartRate() {
        HealthStoreManager.shared.fetchHeartRateData(workout: data.workout) { samples, _ in
            DispatchQueue.main.async {
                if let samples = samples {
                    let sampleData = processHeartRateSamples(samples)
                    
                    sampleData.forEach { date, min, max in
                        print("\(date)  最小值: \(min) 最大值: \(max)")
                    }
                    
                    // 处理数据: 提取 min 和 max 展开成 [Double]
                    let observationsData = sampleData.map({ date,min,max in
                        
                        return  Hike.Observation(
                            distanceFromStart: 0,
                            elevation: min..<max,
                            pace: min..<max,
                            heartRate: min..<max
                        )
                       
                    })

                    // 生成 Hike 数据
                    self.hike = Hike(
                        id: 100,
                        name: "Heart Rate Analysis",
                        distance: 1,
                        difficulty: 1,
                        observations:observationsData
                    )
                }
            }
        }
    }

    func processHeartRateSamples(_ samples: [HKQuantitySample], groupSize: Int = 4) -> [(Date, Double, Double)] {
        guard !samples.isEmpty else { return [] }

        var processedData: [(Date, Double, Double)] = []

        // 按时间排序
        let sortedSamples = samples.sorted { $0.startDate < $1.startDate }

        // 按 groupSize（4个数据点）分组
        for chunk in stride(from: 0, to: sortedSamples.count, by: groupSize) {
            let group = sortedSamples[chunk ..< min(chunk + groupSize, sortedSamples.count)] // 取最多 4 个数据点

            let date = group.first!.startDate // 以第一条数据的时间作为该组的时间
            let heartRates = group.map { $0.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute())) }

            let minHR = heartRates.min() ?? 0
            let maxHR = heartRates.max() ?? 0

            processedData.append((date, minHR, maxHR))
        }

        return processedData
    }
}
