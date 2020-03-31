//
//  InfoView.swift
//  NewFTPUploader
//
//  Created by Golos on 12.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    enum Constants {
        static let versionTitle = "Version"
        static let userTitle = "User"
        static let screenTitle = "Info"
        static let logoutButtonTitle = "Log out"
        static let backButtonTitle = "Back"
    }
    
    @Injectable var deviceInfo: DeviceInfoManagerProtocol
    
    let userName: String?
    let logoutHandler: () -> Void
    let hideHandler: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    HStack {
                        Text(Constants.versionTitle)
                        Spacer()
                        Text(deviceInfo.appVersion.orEmpty)
                    }
                    HStack {
                        Text(Constants.userTitle)
                        Spacer()
                        Text(userName.orEmpty)
                    }
                    HStack {
                        Spacer()
                        Button(Constants.logoutButtonTitle, action: logoutHandler)
                            .buttonStyle(
                                RoundedButton(size: CGSize(width: 75, height: 35))
                        )
                        Spacer()
                    }
                }
                .padding(.horizontal, 5)
            }
            .navigationBarTitle(Constants.screenTitle)
            .navigationBarItems(leading: Button(Constants.backButtonTitle,
                                                action: hideHandler))
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(userName: "", logoutHandler: {}, hideHandler: {})
    }
}
