//
//  Personal_Expense_TrackerApp.swift
//  Personal Expense Tracker
//
//  Created by Ashmit Gupta on 2024-07-03.
//

import SwiftUI
import Amplify
import AmplifyPlugins

@main
struct PersonalExpenseTrackerApp: App {
    init() {
        configureAmplify()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }

    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured with auth plugin")
        } catch {
            print("An error occurred setting up Amplify: \(error)")
        }
    }
}
