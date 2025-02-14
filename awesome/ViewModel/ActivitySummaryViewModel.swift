//
//  ViewModel.swift
//  DRC
//
//  Created by dingstock on 2025/2/11.
//

import Foundation
import HealthKit
import SwiftUICore

class ActivitySummaryViewModel: ObservableObject {
    @Published var workouts: [ActivityData] = []
    private let healthManager: HealthStoreManager = HealthStoreManager.shared

    func loadActivityData(for timeRange: TimeRange) {
        healthManager.fetchWorkouts { workouts, _ in
            DispatchQueue.main.async {
                self.workouts = (workouts ?? []).map { ActivityData(workout: $0) }
            }
        }
    }
}

extension Date {
    func format(_ format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current // 使用当前地区
        formatter.timeZone = TimeZone.current // 使用当前时区
        return formatter.string(from: self)
    }
}

