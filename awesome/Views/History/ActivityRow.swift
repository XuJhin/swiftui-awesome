import SwiftUI

struct ActivityRow: View {
    let activity: ActivityRowData
    let onTap: () -> Void
    @State private var isPressed = false

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            
            // 延迟执行导航
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                onTap()
                // 重置状态
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    isPressed = false
                }
            }
        } label: {
            HStack {
                // 图标
                activity.icon
                    .font(.system(size: 24))
                    .foregroundColor(.black)

                // 信息
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(activity.title)
                            .font(.system(size: 17))
                        Text(activity.duration)
                            .foregroundColor(.gray)
                    }

                    HStack(spacing: 4) {
                        Text(activity.dateString)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)

                        ForEach(activity.badges, id: \.self) { badge in
                            Text(badge)
                                .font(.system(size: 12))
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .background(Color.yellow.opacity(0.2))
                                .cornerRadius(2)
                        }
                    }
                }

                Spacer()

                // 右箭头
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.white.opacity(isPressed ? 0.8 : 1))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 1)
            .scaleEffect(isPressed ? 0.95 : 1)
           
           
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ActivityRow(activity: ActivityRowData.activities[0], onTap: {})
        .padding()
}
