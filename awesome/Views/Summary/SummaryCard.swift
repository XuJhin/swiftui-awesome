import SwiftUI

struct SummaryCard: View {
    let cardData: SummaryCardData
    let isSelected: Bool
    
    // 将字符串分割为数字和非数字部分
    private func splitValue(_ text: String) -> [(String, Bool)] {
        let pattern = "([0-9]+)|([^0-9]+)"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(text.startIndex..., in: text)
        let matches = regex.matches(in: text, options: [], range: range)
        
        return matches.map { match in
            if let range = Range(match.range, in: text) {
                let substring = String(text[range])
                let isNumber = substring.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
                return (substring, isNumber)
            }
            return ("", false)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(cardData.title)
                .font(.subheadline)
                .foregroundColor(isSelected ? .white : .gray)
            
            HStack(alignment: .lastTextBaseline, spacing: 0) {
                Image(systemName: "chevron.up")
                    .font(.caption)
                    .foregroundColor(isSelected ? .white : .primary)
                    .padding(.trailing, 4)
                
                // 使用正则分割后的文本
                HStack(alignment: .lastTextBaseline, spacing: 0) {
                    ForEach(splitValue(cardData.value), id: \.0) { part in
                        Text(part.0)
                            .font(part.1 ? .system(size: 28, weight: .bold) : .system(size: 16))
                            .foregroundColor(isSelected ? .white : .primary)
                    }
                }
                
                if let unit = cardData.unit {
                    Text(unit)
                        .font(.caption)
                        .foregroundColor(isSelected ? .white.opacity(0.8) : .gray)
                        .padding(.leading, 2)
                }
            }
            
            Text(cardData.subValue)
                .font(.caption)
                .foregroundColor(isSelected ? .white.opacity(0.8) : .gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(isSelected ? cardData.type.selectedColor : Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 1)
    }
}
