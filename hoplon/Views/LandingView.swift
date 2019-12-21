//
//  LandingView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 16/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct LandingView: View {

    @EnvironmentObject var userAccount: UserAccount

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 5) {
                Image("hoplon.logo.primary")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)

                Text("Hoplon")
                    .foregroundColor(Color("primary"))
                    .font(Font.custom(Constants.Font.logo, size: 30))
                Text("Track Lenders and Borrowers")
                    .foregroundColor(Color("gray"))
                    .font(Font.custom(Constants.Font.title, size: 14))

                Spacer()
                HStack {
                    Spacer()
                }

                NavigationLink(destination: CreateAccountView()) {
                    HStack {
                        Spacer()
                        Text("Get Started")
                        Spacer()
                    }
                    .font(Font.custom(Constants.Font.title, size: 16))
                    .foregroundColor(Color("primary"))
                    .padding()
                    .background(Color("primary").opacity(0.2))
                    .cornerRadius(10)
                }

                NavigationLink(destination: LoginView()) {
                    HStack {
                        Spacer()
                        Text("Log in")
                        Spacer()
                    }
                    .foregroundColor(Color("gray"))
                    .font(Font.custom(Constants.Font.main, size: 16))
                    .padding()
                }
            }
            .padding(.horizontal, 16)
        }
        .accentColor(Color("primary"))
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
