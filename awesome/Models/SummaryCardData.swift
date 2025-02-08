import Foundation

struct SummaryCardData {
    let type: SummaryCardType
    let title: String
    let value: String
    let subValue: String
    let unit: String?
    
    static let summaryCards: [SummaryCardData] = [
        SummaryCardData(
            type: .duration,
            title: "持续时间",
            value: "1小时25分钟",
            subValue: "0分钟",
            unit: nil
        ),
        SummaryCardData(
            type: .energy,
            title: "活动能量",
            value: "14",
            subValue: "0kcal",
            unit: "kcal"
        ),
        SummaryCardData(
            type: .distance,
            title: "距离",
            value: "0.56",
            subValue: "0km",
            unit: "km"
        ),
        SummaryCardData(
            type: .elevation,
            title: "爬升高度",
            value: "0",
            subValue: "0m",
            unit: "m"
        )
    ]
}
