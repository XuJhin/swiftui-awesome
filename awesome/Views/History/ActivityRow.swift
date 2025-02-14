import SwiftUI
import HealthKit

struct ActivityRow: View {
    let activity: ActivityData
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    isPressed = false
                }
            }
        } label: {
            HStack {
                activity.icon()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("\(activity.niceDuration()) \(activity.activityName()) \(activity.appName())")
                            .font(.system(size: 17))
                            .foregroundColor(.black)
                            .bold()
                    }

                    HStack(spacing: 4) {
                        Text(activity.startDate.format())
                            .font(.system(size: 12))
                            .foregroundColor(.black)
//                        if let badges = activity.badges {
//                            ForEach(badges, id: \.self) { badge in
//                                Text(badge)
//                                    .font(.system(size: 12))
//                                    .padding(.horizontal, 4)
//                                    .padding(.vertical, 2)
//                                    .background(Color.yellow.opacity(0.2))
//                                    .cornerRadius(2)
//                            }
//                        }
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
