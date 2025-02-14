//
//  HeartRateZone.swift
//  awesome
//
//  Created by dingstock on 2025/2/13.
//

import Foundation
import SwiftUICore

import SwiftUI

enum HeartRatesData: String, CaseIterable { // 添加 CaseIterable 以便遍历
    case zone1 = "Zone 1 (50-60%)"
    case zone2 = "Zone 2 (60-70%)"
    case zone3 = "Zone 3 (70-80%)"
    case zone4 = "Zone 4 (80-90%)"
    case zone5 = "Zone 5 (90-100%)"

    var color: Color {
        switch self {
        case .zone1: return .blue
        case .zone2: return .green
        case .zone3: return .yellow
        case .zone4: return .orange
        case .zone5: return .red
        }
    }
}

func classifyHeartRate(_ bpm: Double, maxHR: Int) -> HeartRatesData {
    let percentage = bpm / Double(maxHR) * 100
    switch percentage {
    case 50..<60: return .zone1
    case 60..<70: return .zone2
    case 70..<80: return .zone3
    case 80..<90: return .zone4
    case 90...100: return .zone5
    default: return .zone1
    }
}

