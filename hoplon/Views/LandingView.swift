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
            VStack {
                Text("Hoplon")
                Text("Track Lends and Borrows")

                NavigationLink(destination: CreateAccountView()) {
                        Text("Get Started")
                }

                NavigationLink(destination: LoginView()) {
                        Text("Log in")
                }

                Button(action: { self.userAccount.authenticated.toggle() }) {
                    Image(systemName: "person")
                        .padding()
                }
            }
        }
        .accentColor(Color("primary"))
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
