import SwiftUI

struct HistorySection: View {
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 16) {
                HistorySectionHeader()
                ForEach(ActivityRowData.activities) { activity in
                    ActivityRow(activity: activity) {
                        navigationPath.append(activity)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
                }
            }
        }
        .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 0, trailing: 16))
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

struct HistorySectionHeader: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("历史")
                    .font(.headline)
                Text("65项活动")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Image(systemName: "star")
                Image(systemName: "doc.text")
                Image(systemName: "camera")
                Image(systemName: "speaker.wave.2")
            }
            .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}
