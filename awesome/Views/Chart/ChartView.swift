import Charts
import SwiftUI

struct WorkoutData: Identifiable {
    let id = UUID()
    let date: String
    let distance: Double
}

struct ChartView: View {
    let workoutData = [
        WorkoutData(date: "周一", distance: 6.0),
        WorkoutData(date: "周一", distance: 3.5),
        WorkoutData(date: "周二", distance: 5.0),
        WorkoutData(date: "周三", distance: 2.8),
        WorkoutData(date: "周四", distance: 4.2),
        WorkoutData(date: "周五", distance: 3.0),
        WorkoutData(date: "周六", distance: 6.0),
    ]
    
    let chartColor: Color

    var body: some View {
        Chart(workoutData) { data in
            LineMark(
                x: .value("日期", data.date),
                y: .value("距离", data.distance)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(chartColor)
            .lineStyle(StrokeStyle(lineWidth: 4))
        }
        .frame(height: 180)
        .chartXAxis {
            AxisMarks(position: .bottom, values: .automatic) { value in
                AxisValueLabel()
                    .foregroundStyle(.gray)
                    .font(.system(size: 12, weight: .bold))
                AxisGridLine()
                    .foregroundStyle(Color.gray.opacity(0.2))
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                AxisValueLabel()
                    .foregroundStyle(.gray)
                    .font(.system(size: 12, weight: .bold))
                AxisGridLine()
                    .foregroundStyle(Color.gray.opacity(0.2))
            }
        }
    }
}
