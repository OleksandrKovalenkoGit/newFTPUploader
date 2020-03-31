//
//  AuthorizationView.swift
//  NewFTPUploader
//
//  Created by Golos on 02.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import SwiftUI

struct AuthorizationView: View {
    enum Constats {
        static let title = "FTP Uploader"
        static let loginPlacehodler = "Login"
        static let passwordPlacehodler = "Password"
        static let buttonTitle = "Login"
    }
    
    @EnvironmentObject private var store: Store<AppState, AppAction>
    @State private var isAlertShown = false
    
    @State var loginText = ""
    @State var passwordText = ""
    
    var body: some View {
        ZStack {
            Color.secondary.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack {
                Text(Constats.title)
                    .font(.largeTitle)
                
                TextField(Constats.loginPlacehodler,
                          text: $loginText,
                          onCommit: loginAction)
                    .textFieldStyle(RoundedField())
                
                if store.state.auth.loginError != nil {
                    Text(store.state.auth.loginError.orEmpty)
                        .foregroundColor(.red)
                }
                
                SecureField(Constats.passwordPlacehodler,
                            text: $passwordText,
                            onCommit: loginAction)
                    .textFieldStyle(RoundedField())
                
                if store.state.auth.passwordError != nil {
                    Text(store.state.auth.passwordError.orEmpty)
                        .foregroundColor(.red)
                }
                
                Button(Constats.buttonTitle, action: loginAction)
                    .buttonStyle(
                        RoundedButton(size: CGSize(width: 100, height: 50))
                )
            }
            .padding(.bottom, 100)
            .padding([.leading, .trailing], 44)
            .alert(isPresented: $isAlertShown) {
                Alert(title: Text(store.state.auth.apiError.orEmpty))
            }
            if store.state.auth.isLoading {
                LoaderView()
            }
        }
        .onReceive(store.$state) {
            self.isAlertShown = $0.auth.apiError != nil
        }
    }
    
    private func loginAction() {
        store.send(.auth(.startLoading))
        store.send(AuthEffect(login: loginText,
                              password: passwordText,
                              pushToken: store.state.auth.pushToken))
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
