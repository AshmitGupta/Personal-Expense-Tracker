//
//  LoginView.swift
//  Personal Expense Tracker
//
//  Created by Ashmit Gupta on 2024-07-03.
//

//
//  LoginView.swift
//  Personal Expense Tracker
//
//  Created by Ashmit Gupta on 2024-07-03.
//

import SwiftUI
import Amplify

struct LoginView: View {
    @State private var enteredUsername: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @Binding var showSignUp: Bool
    @Binding var showForgotPassword: Bool
    @Binding var isLoggedIn: Bool
    @Binding var loggedInUsername: String

    var body: some View {
        VStack {
            Spacer()

            Text("Personal Expense Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
                .multilineTextAlignment(.center)

            TextField("Username", text: $enteredUsername)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.horizontal)
                .padding(.bottom, 10)

            HStack {
                Spacer()
                Button(action: {
                    showForgotPassword = true
                }) {
                    Text("Forgot?")
                        .font(.footnote)
                        .foregroundColor(.orange)
                }
                .padding(.horizontal)
            }

            Button(action: {
                logOutUserIfNeeded()
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

            HStack {
                Text("Don't have an account?")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Button(action: {
                    showSignUp = true
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

    private func logOutUserIfNeeded() {
        Amplify.Auth.fetchAuthSession { result in
            switch result {
            case .success(let session):
                if session.isSignedIn {
                    Amplify.Auth.signOut { signOutResult in
                        switch signOutResult {
                        case .success:
                            print("Successfully signed out")
                            loginUser()
                        case .failure(let error):
                            alertMessage = "Sign out failed: \(error.localizedDescription)"
                            showingAlert = true
                            print("Sign out failed: \(error.localizedDescription)")
                        }
                    }
                } else {
                    loginUser()
                }
            case .failure(let error):
                alertMessage = "Failed to fetch auth session: \(error.localizedDescription)"
                showingAlert = true
                print("Failed to fetch auth session: \(error.localizedDescription)")
            }
        }
    }

    private func loginUser() {
        Amplify.Auth.signIn(username: enteredUsername, password: password) { result in
            switch result {
            case .success(let signInResult):
                switch signInResult.nextStep {
                case .done:
                    print("Sign in succeeded")
                    fetchUserAttributes()
                default:
                    alertMessage = "Sign in next step: \(signInResult.nextStep)"
                    showingAlert = true
                    print("Sign in next step: \(signInResult.nextStep)")
                }
            case .failure(let error):
                alertMessage = "Sign in failed: \(error.localizedDescription)"
                showingAlert = true
                print("Sign in failed: \(error.localizedDescription)")
                print("Error details: \(error)")
            }
        }
    }

    private func fetchUserAttributes() {
        Amplify.Auth.fetchUserAttributes { result in
            switch result {
            case .success(let attributes):
                if let customUsernameAttr = attributes.first(where: { $0.key.rawValue == "custom:username" }) {
                    loggedInUsername = customUsernameAttr.value
                    isLoggedIn = true
                } else {
                    alertMessage = "Failed to fetch username attribute"
                    showingAlert = true
                }
            case .failure(let error):
                alertMessage = "Failed to fetch user attributes: \(error.localizedDescription)"
                showingAlert = true
                print("Failed to fetch user attributes: \(error.localizedDescription)")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showSignUp: .constant(false), showForgotPassword: .constant(false), isLoggedIn: .constant(false), loggedInUsername: .constant(""))
    }
}
