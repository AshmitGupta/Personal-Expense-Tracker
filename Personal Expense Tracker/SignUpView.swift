//
//  SignUpView.swift
//  Personal Expense Tracker
//
//  Created by Ashmit Gupta on 2024-07-04.
//

import SwiftUI
import UIKit

struct SignUpView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @Binding var showSignUp: Bool

    var body: some View {
        VStack {
            Spacer()

            Text("Personal Expense Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
                .multilineTextAlignment(.center)

            HStack {
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5.0)
            }
            .padding(.horizontal)

            HStack {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5.0)
            }
            .padding(.horizontal)

            HStack {
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5.0)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)

            Button(action: {
                registerUser()
            }) {
                Text("SIGN UP")
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
                Text("Already have an account?")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Button(action: {
                    showSignUp = false
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

    private func registerUser() {
        if username.isEmpty || email.isEmpty || password.isEmpty {
            alertMessage = "Please fill in all fields."
            showingAlert = true
        } else {
            print("Registering user \(username) with email \(email)")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignUp: .constant(true))
    }
}
