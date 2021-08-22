//
//  SearchBar.swift
//  GithubRepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/22.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
    }
}
