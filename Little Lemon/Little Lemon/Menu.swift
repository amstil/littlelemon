//
//  Menu.swift
//  Little Lemon
//
//  Created by Anastasia on 09.11.23.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Text("Little Lemon").foregroundColor(Color(red: 0.5191, green: 0.4383, blue: 0.00426)).font(.system(size:40)).padding(.horizontal, 10)
            Text("Chicago").foregroundColor(Color.black).font(.system(size: 20)).padding(.leading, 10).padding(.bottom, 10)
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.").padding(.leading, 10)
            List {
                
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
