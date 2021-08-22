//
//  ContentView.swift
//  GithubRepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RepositorySearchView(searchViewModel: SearchViewModel(repository: SearchRepository()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
