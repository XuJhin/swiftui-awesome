import Foundation

enum TimeRange: String, CaseIterable {
    case week = "周"
    case month = "月"
    case year = "年"
    case all = "所有时间"
    
    var title: String {
        return "本\(self.rawValue)"
    }
    
    var subtitle: String {
        switch self {
        case .week:
            return "vs 上周"
        case .month:
            return "vs 上月"
        case .year:
            return "vs 去年"
        case .all:
            return ""
        }
    
    }
}
