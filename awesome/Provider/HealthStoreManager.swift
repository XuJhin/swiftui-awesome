//
//  WorkoutProvider.swift
//  DRC
//
//  Created by dingstock on 2025/2/11.
//

import Foundation
import HealthKit

class HealthStoreManager {
    let HKTypesToShare: Set = [
        HKQuantityType.workoutType(),
        HKSeriesType.workoutRoute(),
        HKQuantityType(.heartRate),
        HKQuantityType(.distanceWalkingRunning),
        HKQuantityType(.runningSpeed),
    ]

    let HKTypesToRead: Set = [
        HKObjectType.workoutType(),
        // 运动轨迹
        HKSeriesType.workoutRoute(),
        // 健身记录
        HKObjectType.activitySummaryType(),
        // 活动能量
        HKQuantityType(.activeEnergyBurned),
        // 跑步距离
        HKQuantityType(.distanceWalkingRunning),
        // 跑步功率
        HKQuantityType(.runningPower),
        // 跑步速度
        HKQuantityType(.runningSpeed),
        // 跑步步长
        HKQuantityType(.runningStrideLength),
        // 触地时间
        HKQuantityType(.runningGroundContactTime),

        // 心率相关
        HKQuantityType(.heartRate),
        // 心率变异性HRV
        HKQuantityType(.heartRateVariabilitySDNN),
        // 静息心率
        HKQuantityType(.restingHeartRate),
        // 运动后心率恢复
        HKQuantityType(.heartRateRecoveryOneMinute),

        // 最大摄氧量
        HKQuantityType(.vo2Max),

        // 睡眠
        HKCategoryType(.sleepAnalysis),
    ]

    // TODO: 代码中healthStore 跟其他地方有重复，等需求和ui确定以后 拆分
    static let shared = HealthStoreManager()
    let healthStore = HKHealthStore()

    func fetchWorkouts(completion: @escaping ([HKWorkout]?, Error?) -> Void) {
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .running) // 只获取跑步数据
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)

        let endDate = Date() // 当前时间
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: endDate)! // 7 天前
        /// 查询时间
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKSampleQuery(sampleType: HKObjectType.workoutType(),
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: [sortDescriptor]) { _, samples, error in
            DispatchQueue.main.async {
                completion(samples as? [HKWorkout], error)
            }
        }
        execute(query)
    }

    /// 通过workout 查询心率
    func fetchHeartRateData(workout: HKWorkout,completion: @escaping ([HKQuantitySample]?, Error?) -> Void) {
        let startDate = workout.startDate
        let endDate = workout.endDate

        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)

        let heartRateQuery = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, samples, error in
            guard let samples = samples as? [HKQuantitySample], error == nil else {
                print("查询心率数据失败: \(String(describing: error))")
                return
            }

            
            DispatchQueue.main.async {
                completion(samples, error)
            }
            
            
        }
        healthStore.execute(heartRateQuery)
    }

    // MARK: - Query Execution

    /// 执行 HealthKit 查询
    /// - Parameter query: 要执行的查询
    func execute(_ query: HKQuery) {
        healthStore.execute(query)
    }

    /// 停止 HealthKit 查询
    /// - Parameter query: 要停止的查询
    func stop(_ query: HKQuery) {
        healthStore.stop(query)
    }
}

extension HealthStoreManager {
  
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("Health data is not available on this device.")
            return
        }
        Task {
            do {
              healthStore.requestAuthorization(toShare: HKTypesToShare, read: HKTypesToRead){success,error in
                    if success{
                        print("已经获取授权")
                    }else{
                        print("\(error)")
                    }
                }
            } catch {
            }
        }
    }
}
