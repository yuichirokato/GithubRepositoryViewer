//
//  GithubRepositoryItems.swift
//  RepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/21.
//

import Foundation

struct GithubRepositoryItems: Decodable {
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
    let totalCount: Int
    let incompleteResults: Bool
    let items: [GithubRepository]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        totalCount = try container.decode(Int.self, forKey: .totalCount)
        incompleteResults = try container.decode(Bool.self, forKey: .incompleteResults)
        items = try container.decode([GithubRepository].self, forKey: .items)
    }
}
