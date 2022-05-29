//
//  Tracker_MoneyApp.swift
//  Tracker Money
//
//  Created by David on 5/26/22.
//

import SwiftUI

@main
struct Tracker_MoneyApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            
            case .background:
                print("Scene is in background")
                persistenceController.save()
            case .inactive:
                print("Scene is in inactive")
            case .active:
                print("Scene is in active")
            @unknown default:
                print("Apple must changed")
            }
        }
    }
}
