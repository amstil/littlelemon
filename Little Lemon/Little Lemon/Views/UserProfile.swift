//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Anastasia on 09.11.23.
//

import SwiftUI

struct UserProfile: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.presentationMode) var presentation
    
    @State private var orderStatuses = true
    @State private var passwordChanges = true
    @State private var specialOffers = true
    @State private var newsletter = true
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    @State private var isLoggedOut = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            NavigationLink(destination: Onboarding(), isActive: $isLoggedOut) { }
            VStack(spacing: 5) {
                VStack {
                    Text("Avatar")
                        .textStyle()
                    HStack(spacing: 0) {
                        Image("profile-image-placeholder")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(maxHeight: 75)
                            .clipShape(Circle())
                            .padding(.trailing)
                        Button("Change") { }
                            .buttonStyle(ButtonStyleProfile())
                        Button("Remove") { }
                            .foregroundColor(.darkGreen)
                            .padding(10)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.darkGreen, lineWidth: 1)
                            )
                        Spacer()
                    }
                }
                
                VStack{
                    Text("First name")
                        .textStyle()
                    TextField("First Name", text: $firstName)
                    Text("Last name")
                        .textStyle()
                    TextField("Last Name", text: $lastName)
                    Text("E-mail")
                        .textStyle()
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                    Text("Phone number")
                        .textStyle()
                    TextField("Phone number", text: $phoneNumber)
                        .keyboardType(.default)
                }
            }
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
            .padding(20)
            
            Text("Email notifications")
                .font(.title3)
                .foregroundColor(.darkGreen)
            VStack {
                Toggle("Order statuses", isOn: $orderStatuses)
                Toggle("Password changes", isOn: $passwordChanges)
                Toggle("Special offers", isOn: $specialOffers)
                Toggle("Newsletter", isOn: $newsletter)
            }
            .padding(10)
            .font(.title3)
            .foregroundColor(.darkGreen)
            
            Button(action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                UserDefaults.standard.set("", forKey: kFirstName)
                UserDefaults.standard.set("", forKey: kLastName)
                UserDefaults.standard.set("", forKey: kEmail)
                UserDefaults.standard.set("", forKey: kPhoneNumber)
                UserDefaults.standard.set(false, forKey: kOrderStatuses)
                UserDefaults.standard.set(false, forKey: kPasswordChanges)
                UserDefaults.standard.set(false, forKey: kSpecialOffers)
                UserDefaults.standard.set(false, forKey: kNewsletter)
                isLoggedOut = true
            }, label: {Text("Log out")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellowLemon)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
            })
            .padding(10)
            
            Spacer(minLength: 20)
            HStack {
                Button("Discard Changes") {
                    firstName = viewModel.firstName
                    lastName = viewModel.lastName
                    email = viewModel.email
                    phoneNumber = viewModel.phoneNumber
                    
                    orderStatuses = viewModel.orderStatuses
                    passwordChanges = viewModel.passwordChanges
                    specialOffers = viewModel.specialOffers
                    newsletter = viewModel.newsletter
                    self.presentation.wrappedValue.dismiss()
                }
                .foregroundColor(.darkGreen)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.darkGreen, lineWidth: 1)
                )
                Button("Save changes") {
                    if viewModel.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                        UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
                        UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
                        UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
                        UserDefaults.standard.set(newsletter, forKey: kNewsletter)
                        self.presentation.wrappedValue.dismiss()
                    }
                }
                .buttonStyle(ButtonStyleProfile())
            }
            if viewModel.errorMessageShow {
                withAnimation() {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
            
        }
        .onAppear {
            firstName = viewModel.firstName
            lastName = viewModel.lastName
            email = viewModel.email
            phoneNumber = viewModel.phoneNumber
            
            orderStatuses = viewModel.orderStatuses
            passwordChanges = viewModel.passwordChanges
            specialOffers = viewModel.specialOffers
            newsletter = viewModel.newsletter
        }
        .navigationTitle(Text("Personal information"))
        .navigationBarTitleDisplayMode(.inline)
    }
}
//struct UserProfile: View {
//    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
//    let lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
//    let email = UserDefaults.standard.string(forKey: kEmail) ?? ""
//
//    @Environment(\.presentationMode) var presentation
//
//    var body: some View {
//        VStack {
//            Text("Personal information")
//            Image("profile-image-placeholder")
//            Text(firstName)
//            Text(lastName)
//            Text(email)
//            Button(action: {
//                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
//                self.presentation.wrappedValue.dismiss()
//            }, label: {Text("Logout")})
//            Spacer()
//        }
//
//    }
//}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}

struct ButtonStyleProfile: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.darkGreen : .white)
            .padding(10)
            .background(configuration.isPressed ? .white : Color.darkGreen)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.darkGreen, lineWidth: 1)
            )
            .padding(.horizontal)
    }
}
