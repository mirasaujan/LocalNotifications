//
//  ContentView.swift
//  Example
//
//  Created by Miras Karazhigitov on 29.10.2022.
//

import SwiftUI
import LocalNotifications

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                LocalNotificationScheduler.shared.requestAuthorization()
                LocalNotificationScheduler.shared.add(LocalNotification(title: "Hello world", body: "From here", timeInterval: 60, repeats: true))
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    LocalNotificationScheduler.shared.add(LocalNotification(title: "Another push", body: "Love it", timeInterval: 60, repeats: true))
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
