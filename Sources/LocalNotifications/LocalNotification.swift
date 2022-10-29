//
//  LocalNotification.swift
//  
//
//  Created by Miras Karazhigitov on 29.10.2022.
//

import UserNotifications
import MapKit

public struct LocalNotification {
    // Identifier
    public let id: String

    // Contains the internal instance of the notification
    let localNotificationRequest: UNNotificationRequest?

    // Title
    let title: String

    // Subtitle
    let subtitle: String

    // Body
    let body: String

    // Sound
    let soundName: String

    // Repeating interval for notification
    let timeInterval: TimeInterval?

    // Due date
    let dueDate: Date?

    // Is notification repeatable
    var repeats: Bool = false

    // Is notification scheduled
    var scheduled: Bool {
        dueDate != nil
    }

    public init(
        id: String = UUID().uuidString,
        localNotificationRequest: UNNotificationRequest? = nil,
        title: String = "",
        subtitle: String = "",
        body: String = "",
        soundName: String = "",
        timeInterval: TimeInterval? = nil,
        dueDate: Date? = nil,
        repeats: Bool = false
    ) {
        self.id = id
        self.localNotificationRequest = localNotificationRequest
        self.title = title
        self.subtitle = subtitle
        self.body = body
        self.soundName = soundName
        self.timeInterval = timeInterval
        self.dueDate = dueDate
        self.repeats = repeats
    }
}

extension UNNotificationRequest {
    convenience init(localNotification: LocalNotification) {
        let content = UNMutableNotificationContent()
        content.title = localNotification.title
        content.subtitle = localNotification.subtitle
        content.body = localNotification.body
        content.sound = .default

        var trigger: UNNotificationTrigger
        if let timeInterval = localNotification.timeInterval {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: localNotification.repeats)
        } else if let dueDate = localNotification.dueDate {
            trigger = UNCalendarNotificationTrigger(dateMatching: dueDate.components(), repeats: localNotification.repeats)
        } else {
            // Hardcode, otherwise local notification does not appear
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.5, repeats: localNotification.repeats)
        }

        self.init(
            identifier: localNotification.id,
            content: content,
            trigger: trigger
        )
    }
}
extension Date {
    func components() -> DateComponents {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: self)
        return components
    }
}
