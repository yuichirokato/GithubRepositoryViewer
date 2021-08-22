//
//  GithubRepositoryPresentationModel.swift
//  RepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/21.
//

import Foundation

struct GithubRepositoryPresentationModel: Identifiable {
    let id: String
    let ownerName: String
    let ownerIconURL: URL?
    let title: String
    let description: String
    let starCount: String
    let language: String
    
    init(id: String,
         ownerName: String,
         ownerIconURL: URL?,
         title: String,
         description: String,
         starCount: String,
         language: String) {
        self.id = id
        self.ownerName = ownerName
        self.ownerIconURL = ownerIconURL
        self.title = title
        self.description = description
        self.starCount = starCount
        self.language = language
    }
    
    init(from githubRepository: GithubRepository) {
        id = String(githubRepository.id)
        ownerName = githubRepository.owner.login
        ownerIconURL = githubRepository.owner.avatarURL
        title = githubRepository.name
        description = githubRepository.repositoryDescription ?? ""
        starCount = String(githubRepository.stargazersCount)
        language = githubRepository.language ?? "None"
    }
}
