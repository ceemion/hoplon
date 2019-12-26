//
//  ContentView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 24/11/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0

    @EnvironmentObject var userAccount: UserAccount

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font: UIFont(name: Constants.Font.nav, size: 34)!]
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont(name: Constants.Font.nav, size: 18)!]
    }
 
    var body: some View {
        Group {
            if userAccount.authenticated {
                TabView(selection: $selection) {
                    PersonsView()
                        .font(.title)
                        .tabItem {
                            VStack {
                                Image(systemName: "person.3")
                                Text("Persons")
                            }
                        }
                        .tag(0)
                    ProfileView()
                        .font(.title)
                        .tabItem {
                            VStack {
                                Image(systemName: "gear")
                                Text("Profile")
                            }
                        }
                        .tag(1)
                }
                .accentColor(Color("primary"))
            } else if userAccount.redirectToLogin {
                LoginView()
            } else {
                LandingView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
