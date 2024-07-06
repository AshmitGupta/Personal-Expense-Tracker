//
//  HomeView.swift
//  Personal Expense Tracker
//
//  Created by Ashmit Gupta on 2024-07-05.
//

import SwiftUI

struct HomeView: View {
    let username: String

    var body: some View {
        VStack {
            Text("Hi, \(username)!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Spacer()

            Text("Welcome to your Personal Expense Tracker")
                .font(.headline)
                .padding()

            Spacer()
        }
        .background(Color(.systemBackground))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(username: "Ashmit")
    }
}
