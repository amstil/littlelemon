//
//  Home.swift
//  Little Lemon
//
//  Created by Anastasia on 09.11.23.
//

import SwiftUI

struct Home: View {
    //let persistence = PersistenceController.shared

    var body: some View {
        TabView {
            Menu().tabItem({Label("Menu", systemImage: "list.dash")})
            UserProfile().tabItem({Label("Profile", systemImage: "square.and.pencil")})
        }.navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
