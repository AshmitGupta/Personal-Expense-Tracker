//
//  SignUpView.swift
//  Personal Expense Tracker
//
//  Created by Ashmit Gupta on 2024-07-04.
//

import SwiftUI
import Amplify

struct SignUpView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var usernameError: String?
    @State private var passwordError: String?
    @Binding var showSignUp: Bool
    @State private var navigateToConfirmation = false

    var body: some View {
        VStack {
            Spacer()

            Text("Personal Expense Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
                .multilineTextAlignment(.center)

            VStack(alignment: .leading) {
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5.0)
                if let usernameError = usernameError {
                    Text(usernameError)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5.0)
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5.0)
                if let passwordError = passwordError {
                    Text(passwordError)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)

            Button(action: {
                validateInputs()
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
            .background(
                NavigationLink(
                    destination: ConfirmationView(username: $username, showSignUp: $showSignUp),
                    isActive: $navigateToConfirmation,
                    label: { EmptyView() }
                )
            )

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

    private func validateInputs() {
        usernameError = nil
        passwordError = nil

        if username.isEmpty {
            usernameError = "Username cannot be empty."
        } else if !isValidUsername(username) {
            usernameError = "Username is invalid. It must contain letters, numbers, and special characters."
        }

        if password.isEmpty {
            passwordError = "Password cannot be empty."
        } else if password.count < 8 {
            passwordError = "Password must be at least 8 characters long."
        }

        if usernameError == nil && passwordError == nil {
            registerUser()
        }
    }

    private func registerUser() {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        Amplify.Auth.signUp(username: username, password: password, options: .init(userAttributes: userAttributes)) { result in
            switch result {
            case .success:
                print("Sign up successful")
                navigateToConfirmation = true
            case .failure(let error):
                print("Sign up failed: \(error)")
                handleSignUpError(error)
            }
        }
    }

    private func handleSignUpError(_ error: AuthError) {
        switch error {
        case .service(let message, _, _):
            if message.contains("username") {
                usernameError = "Username is invalid. Please use a different one."
            } else if message.contains("password") {
                passwordError = "Password is invalid. Please use a stronger one."
            } else {
                alertMessage = message
            }
        default:
            alertMessage = "Sign up failed: \(error.localizedDescription)"
        }
        showingAlert = true
    }

    private func isValidUsername(_ username: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[\\p{L}\\p{M}\\p{S}\\p{N}\\p{P}]+")
        let range = NSRange(location: 0, length: username.utf16.count)
        return regex.firstMatch(in: username, options: [], range: range) != nil
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignUp: .constant(true))
    }
}
