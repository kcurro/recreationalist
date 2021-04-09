//
//  AuthenticationView.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 4/2/21.
//

import SwiftUI

//MARK: -AUTHENTICATION VIEW
struct AuthenticationView: View {
    //MARK: -PROPERTIES
    //MARK: -BODY
    var body: some View {
        NavigationView {
            SignInView()
        }
    }
}

//MARK: -SECURE INPUT VIEW
//Create a SecureField that allows you to show and hide password
struct SecureInputView: View {
    //MARK: - PROPERTIES
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    //MARK: -BODY
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecured {
                SecureField(title, text: $text)
            } else {
                TextField(title, text: $text)
            }
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.secondary)
            }
        }
    }
}

//MARK: - SIGN IN VIEW
// Allow user to sign in using email authentication
struct SignInView: View {
    //MARK: -PROPERTIES
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: FirebaseSession
    
    //MARK: -BODY
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .green]),
                           startPoint: .leading,
                           endPoint: .trailing)
                .mask(Text("Recreationalist")
                        .font(.system(size: 40, weight: .heavy)))
            
            /*Image("RecreationalistLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)*/
            
            VStack(spacing: 18) {
                TextField("Email Address", text: $email)
                    .font(.system(size: 20))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.primary, lineWidth: 2))
                
                SecureInputView("Password", text: $password)
                    .font(.system(size: 20))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.primary, lineWidth: 2))
            }
            .padding(.vertical, 16)
            
            HStack{
                Button(action: signIn) {
                     Text("Sign In")
                         .frame(minWidth: 0, maxWidth: .infinity)
                         .frame(height: 50)
                         .foregroundColor(.black)
                         .font(.system(size: 24, weight: .bold))
                        .background(Color.yellow)
                         .cornerRadius(5)
                 }
                
                NavigationLink(destination: SignUpView()) {
                     Text("Sign Up")
                         .frame(minWidth: 0, maxWidth: .infinity)
                         .frame(height: 50)
                         .foregroundColor(.black)
                         .font(.system(size: 24, weight: .bold))
                        .background(Color.green)
                         .cornerRadius(5)
                 }
            }
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
    
    func signIn() {
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
}

//MARK: - SIGN UP VIEW
//Allow new users to create an account
struct SignUpView: View {
    //MARK: -PROPERTIES
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: FirebaseSession
    
    //MARK: -BODY
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .green]),
                           startPoint: .leading,
                           endPoint: .trailing)
                .mask(Text("Create Account")
                        .font(.system(size: 40, weight: .heavy)))
            
            Text("Sign Up to Enjoy Recreationalist!")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.primary)
            
            VStack(spacing: 18) {
                TextField("Email Address", text: $email)
                    .font(.system(size: 20))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.primary, lineWidth: 2))
                
                SecureInputView("Password", text: $password)
                    .font(.system(size: 20))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.primary, lineWidth: 2))
            }
            .padding(.vertical, 16)
            
            Button(action: signUp) {
                Text("Create Account")
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height: 50)
                    .foregroundColor(.black)
                    .font(.system(size: 24, weight: .bold))
                    .background(Color.green)
                    .cornerRadius(5)
            }
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
            
        }.padding(.horizontal, 32)
    }
    
    func signUp() {
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
}

//MARK: -PREVIEW
struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView().environmentObject(FirebaseSession())
    }
}
