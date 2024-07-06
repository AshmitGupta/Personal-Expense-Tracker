//
//  ConfirmationView.swift
//  Personal Expense Tracker
//
//  Created by Ashmit Gupta on 2024-07-05.
//

import SwiftUI
import Amplify

struct ConfirmationView: View {
    @State private var confirmationCode: String = ""
    @Binding var username: String
    @Binding var showSignUp: Bool
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Spacer()

            Text("Enter Confirmation Code")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
                .multilineTextAlignment(.center)

            TextField("Confirmation Code", text: $confirmationCode)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.horizontal)

            Button(action: {
                confirmSignUp()
            }) {
                Text("CONFIRM")
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
        }
        .padding()
    }

    private func confirmSignUp() {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirmation successful")
                alertMessage = "Confirmation successful! You can now log in."
                showingAlert = true
                showSignUp = false
            case .failure(let error):
                if case .service(_, let errorMessage, _) = error,
                   errorMessage.contains("Current status is CONFIRMED") {
                    alertMessage = "User is already confirmed. You can log in."
                    showingAlert = true
                    showSignUp = false
                } else {
                    print("Confirmation failed: \(error)")
                    alertMessage = "Confirmation failed: \(error.localizedDescription)"
                    showingAlert = true
                }
            }
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(username: .constant(""), showSignUp: .constant(true))
    }
}
