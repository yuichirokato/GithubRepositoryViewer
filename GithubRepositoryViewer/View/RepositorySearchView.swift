//
//  RepositroySearchView.swift
//  RepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/21.
//

import SwiftUI

struct RepositorySearchView: View {
    @ObservedObject private var searchViewModel: SearchViewModel

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchViewModel.searchText)
                List {
                    ForEach(searchViewModel.githubRepositoryPresentationModels.indices, id: \.self) { index in
                        RepositoryRowView(repository: $searchViewModel.githubRepositoryPresentationModels[index])
                    }
                }
                .navigationTitle("検索")
            }
        }
    }

    init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }
}

struct RepositroySearchView_Previews: PreviewProvider {
    static var previews: some View {
        RepositorySearchView(searchViewModel: SearchViewModel(repository: SearchRepository()))
    }
}
