//
//  Header.swift
//  Little Lemon
//
//  Created by Anastasia on 11.11.23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Little Lemon")
                        .foregroundColor(Color.yellowLemon)
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Chicago")
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                    
                    Text(
                     """
                     We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
                     """)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Image("Hero_image")
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .frame(maxWidth: 120, maxHeight: 140)
                    .cornerRadius(16)
            }
            .padding()
            .padding(.bottom, 0)
            .background(Color.darkGreen)
            .frame(maxWidth: .infinity, maxHeight: 240)
        }
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
