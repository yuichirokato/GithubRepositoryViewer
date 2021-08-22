//
//  ImageCache.swift
//  GithubRepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/22.
//

import SwiftUI

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct OnMemoryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(url: URL) -> UIImage? {
        get {
            cache.object(forKey: url as NSURL)
        }
        set {
            if let image = newValue {
                cache.setObject(image, forKey: url as NSURL)
            } else {
                cache.removeObject(forKey: url as NSURL)
            }
        }
    }
}
