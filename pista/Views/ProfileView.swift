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
            VStack(alignment: .center, spacing: 20) {
                ZStack(alignment: .center) {
                    Circle()
                        .fill(Color("primary").opacity(0.2))
                        .frame(width: 150, height: 150)
                    HStack(spacing: 0) {
                        Text(userAccount.firstName.prefix(1))
                        Text(userAccount.lastName.prefix(1))
                    }
                    .font(Font.custom(Constants.Font.nav, size: 50))
                    .foregroundColor(Color("primary").opacity(0.7))
                }

                Text("\(userAccount.firstName) \(userAccount.lastName)")
                    .font(Font.custom(Constants.Font.title, size: 20))
                    .foregroundColor(Color("text"))

                Text(userAccount.email)
                    .font(Font.custom(Constants.Font.main, size: 14))
                    .foregroundColor(Color("gray"))

                Text(userAccount.phone)
                    .font(Font.custom(Constants.Font.title, size: 14))
                    .foregroundColor(Color("gray"))

                HStack {
                    Spacer()
                }

                Spacer()
            }
            .navigationBarTitle("Profile")
            .navigationBarItems(trailing:
                HStack(alignment: .center, spacing: 0) {
                    Button(action: { print("edit btn tapped") }) {
                        Image(systemName: "square.and.pencil")
                            .imageScale(.small)
                            .foregroundColor(Color.gray)
                            .accessibility(label: Text("Edit Profile"))
                            .padding()
                    }

                    Button(action: { self.userAccount.logout() }) {
                        Image(systemName: "power")
                            .imageScale(.small)
                            .foregroundColor(Color("danger"))
                            .accessibility(label: Text("Logout"))
                            .padding()
                    }
                }
            )
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
