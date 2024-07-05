//
//  MainView.swift
//  Personal Expense Tracker
//
//  Created by Ashmit Gupta on 2024-07-04.
//

import SwiftUI

struct MainView: View {
    @State private var showSignUp = false
    
    var body: some View {
        NavigationView {
            if showSignUp {
                SignUpView(showSignUp: $showSignUp)
            } else {
                LoginView(showSignUp: $showSignUp)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
