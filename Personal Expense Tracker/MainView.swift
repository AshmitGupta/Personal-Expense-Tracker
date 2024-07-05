//
//  MainView.swift
//  Personal Expense Tracker
//
//  Created by Ashmit Gupta on 2024-07-04.
//

import SwiftUI

struct MainView: View {
    @State private var showSignUp = false
    @State private var showForgotPassword = false
    
    var body: some View {
        NavigationView {
            if showForgotPassword {
                ForgotPasswordView(showForgotPassword: $showForgotPassword)
            } else if showSignUp {
                SignUpView(showSignUp: $showSignUp)
            } else {
                LoginView(showSignUp: $showSignUp, showForgotPassword: $showForgotPassword)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
