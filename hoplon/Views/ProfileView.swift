//
//  SettingsView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 24/11/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct ProfileView: View {

    @EnvironmentObject var userAccount: UserAccount

    var body: some View {
        NavigationView {
            VStack {
                Text("Hello Profile View!")
                Button(action: { self.userAccount.logout() }) {
                    Image(systemName: "power")
                        .padding()
                }
            }
            .navigationBarTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
