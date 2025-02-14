import SwiftUI

struct ActivitySummaryView: View {
    @State private var selectedCardIndex: Int? = 0
    @State private var selectedTimeRange: TimeRange = .week
    @State private var navigationPath = NavigationPath()
    @StateObject private var viewModel = ActivitySummaryViewModel()

    var selectedCardType: SummaryCardType {
        guard let index = selectedCardIndex else { return .duration }
        return SummaryCardData.summaryCards[index].type
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                Section {
                    TimeRangeSelector(selectedRange: $selectedTimeRange)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)

                WeeklyChartSection(
                    chartColor: selectedCardType.selectedColor,
                    timeRange: selectedTimeRange
                )
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)

                SummarySection(selectedCardIndex: $selectedCardIndex)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                HistorySection(navigationPath: $navigationPath, viewModel: viewModel)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("活动")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: ActivityData.self) { activity in
                DetailView(data: activity)
            }
            .onAppear {
                viewModel.loadActivityData(for: selectedTimeRange)
            }
        }
    }
}

