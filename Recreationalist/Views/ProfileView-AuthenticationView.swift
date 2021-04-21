//
//  AuthenticationView.swift
//  Recreationalist
//
//  Created by Kimberly Govea on 4/2/21.
//

import UIKit
import SwiftUI
import AuthenticationServices

//MARK: -AUTHENTICATION VIEW
struct ProfileView_AuthenticationView: View {
    //MARK: -PROPERTIES
    @EnvironmentObject var session: FirebaseSession
    @State var authType = AuthenticationType.signin
    //MARK: -BODY
    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                if (!session.isAuthenticating) {
                    AuthenticationFormView(authType: $authType)
                } else {
                    ProgressView()
                }
                
                //apple sign in still does not work well, must revise
                /*SignInAppleButton {
                    self.session.login(with: .signInWithApple)
                }
                .frame(minWidth: 0, maxWidth: 288)
                .frame(height: 50)
                .cornerRadius(5)*/
            }
            .offset(y: UIScreen.main.bounds.width > 320 ? -75 : 0)
            
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

//MARK: - AUTHENTICATION VIEW
// Allow user to sign in/sign up using email authentication
struct AuthenticationFormView: View {

    @EnvironmentObject var session: FirebaseSession

    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConf: String = ""

    @Binding var authType: AuthenticationType

    var body: some View {
        // 1
        LinearGradient(gradient: Gradient(colors: [.yellow, .green]),
                       startPoint: .leading,
                       endPoint: .trailing)
            .mask(Text("Recreationalist")
                    .font(.system(size: 40, weight: .heavy)))
        
        VStack(spacing: 16) {
            // 2
            TextField("Email Address", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            // 3
            SecureInputView("Password", text: $password)
                .textContentType(.password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            //4
            if authType == .signup {
                SecureInputView("Password Confirmation", text: $passwordConf)
                    .textContentType(.password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }

            // 5
            Button(action: emailAuthenticationTapped) {
                Text(authType.text)
                    .font(.callout)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 50)
            .foregroundColor(.black)
            .font(.system(size: 24, weight: .bold))
            .background(Color.yellow)
            .cornerRadius(5)
            .disabled(email.count == 0 && password.count == 0)

            // 6
            Button(action: footerButtonTapped) {
                Text(authType.footerText)
                .font(.callout)
            }
            .foregroundColor(.black)
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .frame(width: 288)
        // 7
        .alert(item: $session.error) { error in
            Alert(title: Text("Error"), message: Text(error.localizedDescription))
        }
    }

    private func emailAuthenticationTapped() {
        switch authType {
        case .signin:
            session.login(with: .emailAndPassword(email: email, password: password))

        case .signup:
            session.signUp(email: email, password: password, passwordConfirmation: passwordConf)
        }
    }

    private func footerButtonTapped() {
        clearFormField()
        authType = authType == .signup ? .signin : .signup
    }

    private func clearFormField() {
        email = ""
        password = ""
        passwordConf = ""
    }
}

struct ProgressView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<ProgressView>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ProgressView>) {
        uiView.startAnimating()
    }
}

struct SignInAppleButton: UIViewRepresentable {
    
    let action: () -> ()

    func makeUIView(context: UIViewRepresentableContext<SignInAppleButton>) -> ASAuthorizationAppleIDButton {
        ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: UIViewRepresentableContext<SignInAppleButton>) {
        uiView.addTarget(context.coordinator, action: #selector(Coordinator.buttonTapped(_:)), for: .touchUpInside)
    }
    
    func makeCoordinator() -> SignInAppleButton.Coordinator {
        Coordinator(action: self.action)
    }

    class Coordinator {
        let action: () -> ()
        init(action: @escaping() -> ()) {
            self.action = action
        }
        
        @objc fileprivate func buttonTapped(_ sender: Any) {
            action()
        }
    }
}

//MARK: -PREVIEW
struct ProfileView_AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView_AuthenticationView().environmentObject(FirebaseSession.shared)
    }
}
