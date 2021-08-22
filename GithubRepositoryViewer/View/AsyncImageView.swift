//
//  AsyncImageView.swift
//  GithubRepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/21.
//

import SwiftUI

struct AsyncImageView<Placeholder: View>: View {
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!).resizable()
            } else {
                placeholder
            }
        }
    }

    private let placeholder: Placeholder
    @StateObject private var loader: ImageLoader

    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
}
