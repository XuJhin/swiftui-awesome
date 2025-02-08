import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let activity: ActivityRowData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // 顶部图片
                if let image = activity.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .clipped()
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    // 标题区域
                    HStack {
                        activity.icon
                            .font(.system(size: 24))
                        Text(activity.title)
                            .font(.title)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 时间和设备信息
                    VStack(alignment: .leading, spacing: 8) {
                        Text(activity.dateString)
                            .foregroundColor(.gray)
                        if let device = activity.device {
                            Text(device)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 徽章
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(activity.badges, id: \.self) { badge in
                                Text(badge)
                                    .font(.system(size: 14))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.yellow.opacity(0.2))
                                    .cornerRadius(4)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 备注
                    if let note = activity.note {
                        Text(note)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // 统计数据
                    HStack(spacing: 40) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("总时间")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(activity.duration)
                                .font(.title2)
                        }
                        
                        if let pace = activity.pace {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("平均步频")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(pace)
                                    .font(.title2)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 20) {
                    Button(action: {}) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                    }
                }
                .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    NavigationView {
        ActivityDetailView(activity: ActivityRowData.activities[0])
    }
}
