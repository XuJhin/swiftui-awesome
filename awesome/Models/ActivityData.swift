import CoreLocation
import Foundation
import HealthKit
import SwiftUI

final class ActivityData: Identifiable, Hashable {
    let workout: HKWorkout
    @Published private(set) var routeData: [CLLocationCoordinate2D]?

    var id: UUID {
        workout.uuid
    }

    var startDate: Date {
        workout.startDate
    }

    // MARK: - Display Properties

    var dateString: String {
        "\(workout.startDate.format("yyyy年M月d日 EEEE")) \(workout.startDate.format("HH:mm"))"
    }

    var device: String? {
        "使用 \(workout.sourceRevision.source.name)"
    }

    var totalTime: String {
        let totalSeconds = Int(workout.duration)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d:%02d", hours, minutes, seconds)
    }

    var averageHeartRate: String? {
        guard let statistics = workout.statistics(for: HKQuantityType(.heartRate)) else { return nil }
        let heartRate = statistics.averageQuantity()?.doubleValue(for: HKUnit.count().unitDivided(by: .minute())) ?? 0
        return "\(Int(heartRate))bpm"
    }

    var maxHeartRate: String? {
        guard let statistics = workout.statistics(for: HKQuantityType(.heartRate)) else { return nil }
        let heartRate = statistics.maximumQuantity()?.doubleValue(for: HKUnit.count().unitDivided(by: .minute())) ?? 0
        return "\(Int(heartRate))bpm"
    }

    var averageSpeed: String? {
        guard let statistics = workout.statistics(for: HKQuantityType(.runningSpeed)) else { return nil }
        let speed = statistics.averageQuantity()?.doubleValue(for: HKUnit.meter().unitDivided(by: .second())) ?? 0
        return String(format: "%.2f", speed)
    }

    var route: [CLLocationCoordinate2D]? {
        routeData
    }

    var badges: [String] {
        // 可以根据运动数据生成徽章，这里先返回空数组
        []
    }

    var note: String? {
        // 如果需要备注功能，可以在这里实现
        nil
    }

    var duration: String {
        workout.niceDuration()
    }

    var pace: String? {
        guard let statistics = workout.statistics(for: HKQuantityType(.runningSpeed)) else { return nil }
        let paceValue = statistics.averageQuantity()?.doubleValue(for: HKUnit.meter().unitDivided(by: .second())) ?? 0
        return String(format: "%.2f m/s", paceValue)
    }

    init(workout: HKWorkout) {
        self.workout = workout
        routeData = nil


    

        loadRouteData()
    }

    private func loadRouteData() {
        let routeType = HKSeriesType.workoutRoute()
        let predicate = HKQuery.predicateForObjects(from: workout)

        let query = HKAnchoredObjectQuery(
            type: routeType,
            predicate: predicate,
            anchor: nil,
            limit: HKObjectQueryNoLimit
        ) { [weak self] _, samples, _, _, _ in
            guard let self = self,
                  let routeSamples = samples as? [HKWorkoutRoute] else { return }

            for route in routeSamples {
                let routeQuery = HKWorkoutRouteQuery(route: route) { [weak self] _, locations, done, _ in
                    guard let self = self,
                          let locations = locations else { return }

                    let coordinates = locations.map { location in
                        CLLocationCoordinate2D(
                            latitude: location.coordinate.latitude,
                            longitude: location.coordinate.longitude
                        )
                    }

                    if done {
                        DispatchQueue.main.async {
                            self.routeData = coordinates
                        }
                    }
                }

                HealthStoreManager.shared.execute(routeQuery)
            }
        }

        HealthStoreManager.shared.execute(query)
    }

    // MARK: - Methods

    func icon() -> Image {
        switch workout.workoutActivityType {
        case .running: return Image(systemName: "figure.run")
        case .cycling: return Image(systemName: "bicycle")
        case .swimming: return Image(systemName: "figure.pool.swim")
        case .walking: return Image(systemName: "figure.walk")
        case .hiking: return Image(systemName: "figure.hiking")
        case .yoga: return Image(systemName: "figure.yoga")
        case .traditionalStrengthTraining: return Image(systemName: "dumbbell")
        case .functionalStrengthTraining: return Image(systemName: "dumbbell")
        case .highIntensityIntervalTraining: return Image(systemName: "flame")
        case .rowing: return Image(systemName: "figure.rower")
        case .elliptical: return Image(systemName: "circle.dotted")
        default: return Image(systemName: "figure.exercise")
        }
    }

    func activityName() -> String {
        switch workout.workoutActivityType {
        case .running: return "户外跑步"
        case .cycling: return "骑行"
        case .swimming: return "游泳"
        case .walking: return "步行"
        case .hiking: return "徒步"
        case .yoga: return "瑜伽"
        case .traditionalStrengthTraining: return "力量训练"
        case .functionalStrengthTraining: return "功能性训练"
        case .highIntensityIntervalTraining: return "高强度间歇训练"
        case .rowing: return "划船机"
        case .elliptical: return "椭圆机"
        default: return "其他"
        }
    }

    func title() -> String {
        return "\(niceDuration()) \(activityName()) \(appName())"
    }

    func appName() -> String {
        return workout.sourceRevision.source.name
    }

    func niceDuration() -> String {
        let totalSeconds = Int(workout.duration)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        if hours > 0 {
            return String(format: "%dh %dm %ds", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format: "%dm %ds", minutes, seconds)
        } else {
            return String(format: "%ds", seconds)
        }
    }

    // MARK: - Hashable

    static func == (lhs: ActivityData, rhs: ActivityData) -> Bool {
        lhs.workout.uuid == rhs.workout.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(workout.uuid)
    }
}
