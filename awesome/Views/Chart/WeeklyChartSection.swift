import SwiftUI

struct WeeklyChartSection: View {
    let chartColor: Color
    let timeRange: TimeRange
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                WeeklyChartHeader(timeRange: timeRange)
                ChartView(chartColor: chartColor)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color(uiColor: .clear))
    }
}

struct WeeklyChartHeader: View {
    let timeRange: TimeRange
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(timeRange.title)
                    .font(.title)
                    .bold()
                Text(timeRange.subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}
