//
//  BuildView.swift
//  NewFTPUploader
//
//  Created by Golos on 31.03.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import SwiftUI

struct BuildView: View {
    enum Constants {
        static let leftColumn = ["Server type:", "Date:", "Uploaded by:"]
        static let installTitle = "Install"
        static let placeholder = "Unknown"
        static let moreTitle = "More"
        
        static let charactersLimit = 80
        static let defaultLimit = 2
    }
    
    @Injectable var dateFormatter: DateFormatterProtocol
    @State var linesLimit: Int? = Constants.defaultLimit
    
    let build: BuildModel
    let installAction: () -> Void
    
    private var rightColumn: [String] {
        [build.serverType.nonEmptyValue ?? Constants.placeholder,
         dateString,
         build.developerName.nonEmptyValue ?? Constants.placeholder]
    }
    
    var dateString: String {
        guard let date = build.createdDate else { return Constants.placeholder }
        return dateFormatter.string(from: Date(timeIntervalSince1970: date))
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            AsyncImageView(url: build.image.orEmpty)
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(build.build)
                    .font(.headline)
                VStack(alignment: .leading) {
                    ForEach(0..<Constants.leftColumn.count) { index in
                        HStack(alignment: .top) {
                            Text(Constants.leftColumn.element(at: index).orEmpty)
                                .font(.footnote)
                            Text(self.rightColumn.element(at: index).orEmpty)
                                .font(.footnote)
                        }
                    }
                }
                Text(build.description.orEmpty)
                    .background(Color.secondary.opacity(0.5))
                    .font(.footnote)
                    .lineLimit(linesLimit)
                
                if build.description.orEmpty.count > Constants.charactersLimit
                    && linesLimit == Constants.defaultLimit {
                    HStack {
                        Spacer()
                        Button(Constants.moreTitle) {
                            self.linesLimit = nil
                        }
                        .foregroundColor(.blue)
                        .font(.caption)
                    }
                }
                HStack {
                    Spacer()
                    Button(Constants.installTitle, action: installAction)
                        .buttonStyle(
                            RoundedButton(size: CGSize(width: 75, height: 35))
                    )
                }
            }
        }
        .padding(.vertical, 10)
    }
}

struct BuildView_Previews: PreviewProvider {
    static var previews: some View {
        let build = BuildModel(build: "test",
                               link: "test",
                               platform: "test",
                               createdDate: 0,
                               image: "test",
                               serverType: "test",
                               description: "test",
                               developerName: "test")
        return BuildView(build: build) {}
            .previewLayout(.fixed(width: 250, height: 150))
    }
}
