//
//  BuildListView.swift
//  NewFTPUploader
//
//  Created by Golos on 31.03.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import SwiftUI

struct BuildListView: View {
    enum Constats {
        static let versionTitle = "Version: "
    }
    
    @EnvironmentObject private var store: Store<AppState, AppAction>
    @State private var isAlertShown = false
    
    let projectId: Int
    let projectName: String
    
    var sections: [String: [BuildModel]] {
        Dictionary(grouping: store.state.builds.builds[projectId].orEmpty) {
            String($0.build.split(separator: "(").first ?? "")
        }
    }
    
    func builds(at key: String) -> [BuildModel] {
        sections[key].orEmpty.sorted { $0.build > $1.build }
    }
    
    var body: some View {
        ZStack {
            List {
                ForEach(Array(sections.keys).sorted(by: >), id: \.self) { item in
                    Section(header: Text(Constats.versionTitle + item)) {
                        ForEach(self.builds(at: item)) { build in
                            BuildView(build: build) {
                                self.installAction(for: build.link)
                            }
                        }
                    }
                }
            }
            .alert(isPresented: $isAlertShown) {
                Alert(title: Text(store.state.builds.apiError.orEmpty))
            }
            .navigationBarTitle(projectName)
            .onAppear(perform: reload)
            .onReceive(store.$state) {
                self.isAlertShown = $0.builds.apiError != nil
            }
            
            if store.state.builds.isLoading {
                LoaderView()
            }
        }
    }
    
    private func reload() {
        store.send(.build(.loading))
        store.send(BuildEffect(projectId: projectId))
    }
    
    private func installAction(for url: String) {
        store.send(.build(.loading))
        store.send(InstallEffect(urlString: url))
    }
}

struct BuildListView_Previews: PreviewProvider {
    static var previews: some View {
        BuildListView(projectId: 0, projectName: "test")
    }
}
