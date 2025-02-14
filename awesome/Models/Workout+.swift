//
//  Workout+.swift
//  DRC
//
//  Created by dingstock on 2025/2/11.
//

import HealthKit
import SwiftUI

extension HKWorkout {
    /// 返回 Workout 的图标
    func icon() -> Image {
        switch workoutActivityType {
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
        default: return Image(systemName: "figure.exercise") // 默认图标
        }
    }

    /// 返回 Workout 的本地化名称
    func activityName() -> String {
        switch workoutActivityType {
        case .running: return "跑步"
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

    /// 将 workout 的 duration（秒）转换为 `hh:mm:ss` 格式
    func niceDuration() -> String {
        let totalSeconds = Int(duration)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%d:%ds", hours, minutes, seconds)
        if hours > 0 {
            return String(format: "%dh %dm %ds", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format: "%dm %ds", minutes, seconds)
        } else {
            return String(format: "%ds", seconds)
        }
    }

  
    func appName() -> String {
        return sourceRevision.source.name
    }
}
