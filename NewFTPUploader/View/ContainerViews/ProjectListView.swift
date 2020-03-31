//
//  ProjectListView.swift
//  NewFTPUploader
//
//  Created by Golos on 04.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import SwiftUI

struct ProjectListView: View {
    enum Constants {
        static let title = "Projects"
        static let reloadImage = "arrow.clockwise"
        static let infoImage = "info.circle"
        static let expirationError = "Access Token is invalid"
    }
    
    @EnvironmentObject private var store: Store<AppState, AppAction>
    @State private var isAlertShown = false
    @State private var isSheetShown = false

    var sortedProjects: [ProjectModel] {
        store.state.projects.projects.sorted { $0.name < $1.name }
    }
    
    var body: some View {
        ZStack {
            List {
                ForEach(sortedProjects) { project in
                    NavigationLink(destination:
                        BuildListView(projectId: project.id,
                                      projectName: project.name)) {
                                        Text(project.name)
                    }
                }
            }
            .sheet(isPresented: $isSheetShown, onDismiss: hideInfo) {
                InfoView(userName: self.store.state.auth.userName,
                         logoutHandler: self.logout,
                         hideHandler: self.hideInfo)
            }
            .alert(isPresented: $isAlertShown) {
                Alert(title: Text(store.state.projects.apiError.orEmpty))
            }
            .navigationBarTitle(Constants.title)
            .navigationBarItems(
                leading: Button(action: showInfo) {
                    Image(systemName: Constants.infoImage)
                },
                trailing: Button(action: reload) {
                    Image(systemName: Constants.reloadImage)
                }
            )
            if store.state.projects.isLoading {
                LoaderView()
            }
        }
        .onAppear(perform: reload)
        .onReceive(store.$state) {
            self.isSheetShown = $0.projects.isInfoShown
            self.isAlertShown = $0.projects.apiError != nil
            
            if $0.projects.apiError == Constants.expirationError {
                self.logout()
                self.store.send(.project(.projectError(nil)))
            }
            if let pushToken = $0.auth.pushToken, $0.auth.token != nil {
                self.store.send(PushEffect(token: pushToken))
            }
        }
    }
    
    private func reload() {
        store.send(.project(.loading))
        store.send(ProjectEffect())
    }
    
    private func showInfo() {
        store.send(.project(.showInfo))
    }
    
    private func logout() {
        store.send(.project(.hideInfo))
        store.send(LogoutEffect())
    }
    
    private func hideInfo() {
        store.send(.project(.hideInfo))
    }
}

struct ProjecttListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListView()
    }
}
