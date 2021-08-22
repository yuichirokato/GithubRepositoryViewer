//
//  ImageLoader.swift
//  GithubRepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/21.
//

import Combine
import SwiftUI

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private let url: URL
    
    private var cancellable: AnyCancellable?
    private var cache: ImageCache?
    private var isLoading: Bool = false
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard !isLoading else { return }

        if let image = cache?[url] {
            self.image = image
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map {
                UIImage(data: $0.data)
            }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.imageWillLoad() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.imageDidLoad() },
                          receiveCancel: { [weak self] in self?.loadCancel() })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.image = $0
            }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}

private extension ImageLoader {
    func cache(_ image: UIImage?) {
        if let image = image {
            cache?[url] = image
        }
    }
    
    func imageWillLoad() {
        isLoading = true
    }
    
    func imageDidLoad() {
        isLoading = false
    }
    
    func loadCancel() {
        isLoading = false
    }
}
