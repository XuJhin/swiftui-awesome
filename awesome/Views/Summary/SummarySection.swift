import SwiftUI

struct SummarySection: View {
    @Binding var selectedCardIndex: Int?
    
    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 16) {
                SummarySectionHeader()
                SummaryCardsGrid(selectedCardIndex: $selectedCardIndex)
            }
        }
        .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 0, trailing: 16))
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

struct SummarySectionHeader: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("摘要")
                    .font(.headline)
                Text("天1-8日")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            HStack(spacing: 8) {
                Image(systemName: "chart.bar.fill")
                    .foregroundColor(.gray)
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundColor(.black)
            }
        }
    }
}

struct SummaryCardsGrid: View {
    @Binding var selectedCardIndex: Int?
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ], spacing: 10) {
            ForEach(Array(SummaryCardData.summaryCards.enumerated()), id: \.element.title) { index, card in
                SummaryCard(cardData: card, isSelected: selectedCardIndex == index)
                    .onTapGesture {
                        selectedCardIndex = index
                    }
            }
        }
    }
}
