import SwiftUI

enum SummaryCardType {
    case duration
    case energy
    case distance
    case elevation
    
    var selectedColor: Color {
        switch self {
        case .duration:
            return .orange
        case .energy:
            return .pink
        case .distance:
            return .green
        case .elevation:
            return .blue
        }
    }
}
