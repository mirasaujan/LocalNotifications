import UserNotifications

public final class LocalNotificationScheduler {
    public static let shared = LocalNotificationScheduler()

    private init() {}

    public func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    public func add(_ notification: LocalNotification) {
        UNUserNotificationCenter.current().add(
            UNNotificationRequest(localNotification: notification)
        )
    }
}
