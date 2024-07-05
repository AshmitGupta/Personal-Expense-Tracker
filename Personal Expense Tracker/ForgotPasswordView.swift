//
//  ForgotPasswordView.swift
//  Personal Expense Tracker
//
//  Created by Ashmit Gupta on 2024-07-04.
//

import SwiftUI
import UIKit

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @Binding var showForgotPassword: Bool

    var body: some View {
        VStack {
            Spacer()

            Text("Personal Expense Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
                .multilineTextAlignment(.center)

            HStack {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5.0)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)

            Button(action: {
                resetPassword()
            }) {
                Text("RESET PASSWORD")
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

            HStack {
                Text("Remembered your password?")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Button(action: {
                    showForgotPassword = false
                }) {
                    Text("Login")
                        .font(.footnote)
                        .foregroundColor(.orange)
                }
            }
            .padding(.bottom, 20)
        }
        .padding()
    }

    private func resetPassword() {
        if email.isEmpty {
            alertMessage = "Please enter your email."
            showingAlert = true
        } else {
            print("Resetting password for email \(email)")
            // Add logic for password reset
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(showForgotPassword: .constant(false))
    }
}
