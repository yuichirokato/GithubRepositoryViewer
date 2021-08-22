//
//  GithubRepository.swift
//  RepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/21.
//

import Foundation

struct GithubRepository: Decodable {
    struct Owner: Decodable {
        enum CodingKeys: String, CodingKey {
            case id
            case login
            case avatarURL = "avatar_url"
            case gravatarID = "gravatar_id"
            case url
            case htmlURL = "html_url"
        }

        let id: Int
        let login: String
        let avatarURL: URL?
        let gravaterID: String
        let url: URL
        let htmlURL: URL
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            id = try container.decode(Int.self, forKey: .id)
            login = try container.decode(String.self, forKey: .login)
            avatarURL = try container.decodeIfPresent(URL.self, forKey: .avatarURL)
            gravaterID = try container.decode(String.self, forKey: .gravatarID)
            url = try container.decode(URL.self, forKey: .url)
            htmlURL = try container.decode(URL.self, forKey: .htmlURL)
        }
    }
        
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case htmlURL = "html_url"
        case repositoryDescription = "description" // すでに定義されている `description` プロパティとの衝突を避けるためこの名前になっている
        case url
        case gitURL = "git_url"
        case language
        case stargazersCount = "stargazers_count"
    }

    let id: Int
    let name: String
    let fullName: String
    let owner: Owner
    let htmlURL: URL
    let repositoryDescription: String?
    let url: URL
    let gitURL: URL
    let language: String?
    let stargazersCount: Int
}
