//
//  APICLient.swift
//  RepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/21.
//

import Combine
import Foundation

struct APIClient {
    func sendGithubRepositoryRequest(with query: String) -> AnyPublisher<[GithubRepository], Error> {
        URLSession
            .shared
            .dataTaskPublisher(for: buildURL(with: query))
            .tryMap { response -> Data in
                guard let httpResponse = response.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return response.data
            }
            .decode(type: GithubRepositoryItems.self, decoder: JSONDecoder())
            .map(\.items)
            .eraseToAnyPublisher()
    }
}

private extension APIClient {
    func buildURL(with query: String) -> URL {
        let baseURL = URL(string: "https://api.github.com/")!
        let path = "search/repositories"
        let dictionary = ["q": query]
        let searchRepositoryURL = baseURL.appendingPathComponent(path)
        
        var component = URLComponents(url: searchRepositoryURL, resolvingAgainstBaseURL: true)!
        component.percentEncodedQuery = URLEncodeSelialization.string(from: dictionary)

        return component.url!
    }
}
