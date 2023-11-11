//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Anastasia on 08.11.23.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"

let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    LittleLemonLogo()
                        .padding(20)
                    Header()
                        .padding(.bottom, 20)
                    VStack {
                        NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                            EmptyView()
                        }
                        Text("First Name *").textStyle()
                        TextField("First Name", text: $firstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Last Name *").textStyle()
                        TextField("Last Name", text: $lastName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("Email *").textStyle()
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled()
                    }
                    .padding(.horizontal, 20)
                    .disableAutocorrection(true)
                    Button(action: {
                        if (!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            isLoggedIn = true
                        }
                    }, label: {Text("Register").padding().background(Color.darkGreen).foregroundColor(.white).cornerRadius(15).frame(width: 260)})
                    .padding(.top, 20)
                }.onAppear { if (UserDefaults.standard.bool(forKey: kIsLoggedIn)) {
                    isLoggedIn = true
                } }
                
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

extension Text {
    func textStyle() -> some View {
        self
            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            .foregroundColor(Color.darkGreen)
            .font(.subheadline)
    }
}
