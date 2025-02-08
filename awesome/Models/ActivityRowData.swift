import SwiftUI

struct ActivityRowData: Identifiable, Hashable {
    let id = UUID() // 作为唯一标识符
    let title: String
    let dateString: String
    let duration: String
    let icon: Image
    let badges: [String]
    let device: String?
    let note: String?
    let pace: String?
    let image: UIImage?

    static let activities: [ActivityRowData] = [
        ActivityRowData(
            title: "运动不停",
            dateString: "2025年2月6日 星期四 19:20",
            duration: "0:00:12",
            icon: Image(systemName: "figure.run"),
            badges: ["收藏"],
            device: "DRC 跟踪",
            note: "一次愉快的跑步",
            pace: "—",
            image: UIImage(named: "workout_image")
        ),
        ActivityRowData(
            title: "户外骑行",
            dateString: "2月6日 星期四",
            duration: "0:00:34",
            icon: Image(systemName: "bicycle"),
            badges: ["收藏"],
            device: nil,
            note: nil,
            pace: nil,
            image: nil
        ),
        ActivityRowData(
            title: "户外骑行",
            dateString: "2月6日 星期四",
            duration: "0:03:57",
            icon: Image(systemName: "bicycle"),
            badges: ["收藏"],
            device: nil,
            note: nil,
            pace: nil,
            image: nil
        ),
        ActivityRowData(
            title: "户外骑行",
            dateString: "2月6日 星期四",
            duration: "0:00:02",
            icon: Image(systemName: "bicycle"),
            badges: ["收藏"],
            device: nil,
            note: nil,
            pace: nil,
            image: nil
        )
    ]

    // ✅ 实现 Hashable 协议，保证 `ActivityRowData` 可以用于 Set 或 `navigationDestination`
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ActivityRowData, rhs: ActivityRowData) -> Bool {
        return lhs.id == rhs.id
    }
}
