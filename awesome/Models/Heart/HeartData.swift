//
//  HeartData.swift
//  awesome
//
//  Created by dingstock on 2025/2/13.
//

import Foundation
import SwiftUICore


struct HeartData{
    var datas:[HeartRateData] = []
    
}

struct HeartRateData: Identifiable {
    let id = UUID()
    let time: Date
    let bpm: Double
    let zone: HeartRatesData
}


