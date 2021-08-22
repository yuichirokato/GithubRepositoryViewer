//
//  EnvironmentValues+ImageCache.swift
//  GithubRepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/22.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static var defaultValue: ImageCache = OnMemoryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
