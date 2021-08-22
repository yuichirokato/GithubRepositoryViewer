//
//  RepositoryRowView.swift
//  RepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/21.
//

import SwiftUI

struct RepositoryRowView: View {
    @Binding var repository: GithubRepositoryPresentationModel

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 4) {
                    AsyncImageView(url: repository.ownerIconURL!, placeholder: { Text("...") })
                        .frame(width: 32, height: 32)
                        .padding(.all, 0)
                    Text(repository.ownerName)
                        .font(Font.system(size: 12))
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 12)
                Text(repository.title)
                    .font(.system(size: 14))
                    .bold()
                    .padding(.bottom, 8)
                Text(repository.description)
                    .font(.system(size: 14))
                    .padding(.bottom, 12)
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Image(systemName: "star")
                        Text(repository.starCount)
                    }

                    Text(repository.language)
                }
            }
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.trailing, 12)
    }
}

struct RepositoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryRowView(repository: .constant( GithubRepositoryPresentationModel(id: "a", ownerName: "yuichirokato", ownerIconURL: URL(string: "https://avatars.githubusercontent.com/u/10639145?v=4")!, title: "XActor", description: "テストのための詳細", starCount: "3", language: "Swift")))
    }
}
