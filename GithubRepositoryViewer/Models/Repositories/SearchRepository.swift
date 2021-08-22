//
//  SearchRepository.swift
//  GithubRepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/22.
//

import Combine

protocol SearchRepositoryInterface {
    func searchGithubRepository(with query: String) -> AnyPublisher<[GithubRepository], Error>
}

struct SearchRepository: SearchRepositoryInterface {
    private let apiClient: APIClient

    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    func searchGithubRepository(with query: String) -> AnyPublisher<[GithubRepository], Error> {
        apiClient.sendGithubRepositoryRequest(with: query)
    }
}
