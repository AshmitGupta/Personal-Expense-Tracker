//
//  LoginView.swift
//  Personal Expense Tracker
//
//  Created by Ashmit Gupta on 2024-07-03.
//

import SwiftUI
import UIKit

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            
            Spacer()

            // Title and Subtitle
            VStack(alignment: .center) {
                Text("Personal Expense Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
            }
            .padding(.horizontal)

            // Username Field
            HStack {
                TextField("Email", text: $username)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5.0)
            }

            // Password Field
            HStack {
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5.0)
            }
            .padding(.bottom, 10)

            // Forgot Password Link
            HStack {
                Spacer()
                Button(action: {
                    // Forgot password action
                }) {
                    Text("Forgot?")
                        .font(.footnote)
                        .foregroundColor(.orange)
                }
                .padding(.horizontal)
            }

            // Login Button
            Button(action: {
                authenticateUser()
            }) {
                Text("LOGIN")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(15.0)
            }
            .padding(.top, 20)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }

            Spacer()

            // Sign Up Link
            HStack {
                Text("Don’t have an account?")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Button(action: {
                    // Sign up action
                }) {
                    Text("Sign up")
                        .font(.footnote)
                        .foregroundColor(.orange)
                }
            }
            .padding(.bottom, 20)
        }
        .padding()
    }

    private func authenticateUser() {
        // Placeholder for authentication logic
        if username.isEmpty || password.isEmpty {
            alertMessage = "Please enter both username and password."
            showingAlert = true
        } else {
            // Perform authentication (this will be replaced with actual authentication logic)
            print("Authenticating user \(username)")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
