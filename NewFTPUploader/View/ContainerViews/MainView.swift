//
//  MainView.swift
//  NewFTPUploader
//
//  Created by Golos on 12.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var store: Store<AppState, AppAction>
    @State private var isSheetShown = false
    
    var navigationView: some View {
        NavigationView {
            ProjectListView()
            BuildListView(projectId: 0, projectName: "")
        }
    }
    
    var body: some View {
        Group {
            if store.state.general.isLandscape {
                navigationView
            } else {
                navigationView.navigationViewStyle(StackNavigationViewStyle())
            }
        }
        .sheet(isPresented: $isSheetShown, onDismiss: reloadProjects) {
            AuthorizationView().environmentObject(self.store)
        }
        .onReceive(store.$state) {
            self.isSheetShown = $0.auth.token == nil
        }
    }
    
    private func reloadProjects() {
        store.send(.project(.loading))
        store.send(ProjectEffect())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
