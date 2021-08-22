//
//  SearchViewModel.swift
//  GithubRepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/22.
//

import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var githubRepositoryPresentationModels: [GithubRepositoryPresentationModel] = []
    @Published var isDisplayErrorView: Bool = false

    private let repository: SearchRepositoryInterface
    
    private var cancellables = Set<AnyCancellable>()

    init(repository: SearchRepositoryInterface) {
        self.repository = repository
        
        $searchText
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .flatMap { [weak self] (query) -> AnyPublisher<[GithubRepository], Error> in
                // TODO: use optional binding later
                self!.repository.searchGithubRepository(with: query)
            }
            .map { (repositories) -> [GithubRepositoryPresentationModel] in
                repositories.map { .init(from: $0) }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] error in
                print("[REQUEST ERROR] \(error)")
                self?.isDisplayErrorView = true
            }, receiveValue: { [weak self] in
                self?.isDisplayErrorView = false
                self?.githubRepositoryPresentationModels = $0
                
            })
            .store(in: &cancellables)
    }
}
