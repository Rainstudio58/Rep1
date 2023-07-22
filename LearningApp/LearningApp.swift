//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Christopher Ching on 2021-03-03.
//

import SwiftUI
import Firebase

@main
struct LearningApp: App {
    
    init() {
        // NOTE: Add your own GoogleService-Info.plist file to point to your own Firebase project
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
