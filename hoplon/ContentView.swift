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
 
    var body: some View {
        TabView(selection: $selection) {
            ContactsView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "person.3")
                        Text("My Contacts")
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
