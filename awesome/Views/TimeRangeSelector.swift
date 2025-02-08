import SwiftUI

struct TimeRangeSelector: View {
    @Binding var selectedRange: TimeRange
    
    var body: some View {
        Picker("TimeRange", selection: $selectedRange) {
            ForEach(TimeRange.allCases, id: \.self) { range in
                Text(range.rawValue).tag(range)
            }
        }
        .pickerStyle(.segmented)
        .frame(width: .infinity)
    }
}

#Preview {
    TimeRangeSelector(selectedRange: .constant(.week))
        .padding()
        .background(.white)
}
