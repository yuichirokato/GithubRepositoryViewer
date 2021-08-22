//
//  URLEncodeSelialization.swift
//  RepositoryViewer
//
//  Created by Yuichirou Takahashi on 2021/08/21.
//

import Foundation

private func percentEncode(string: String) -> String {
    let allowCharacterSet = CharacterSet.alphanumerics.union(.init(charactersIn: "/?-._~"))
    let removedString = string.removingPercentEncoding ?? string

    return removedString.addingPercentEncoding(withAllowedCharacters: allowCharacterSet) ?? removedString
}

struct URLEncodeSelialization {
    static func string(from dictionary: [String: Any]) -> String {
        dictionary.map { key, value -> String in
            if value is NSNull {
                return percentEncode(string: key)
            }
            
            let valueString = (value as? String) ?? String(describing: value)
            return "\(percentEncode(string: key))=\(percentEncode(string: valueString))"
        }.joined(separator: "&")
    }
}
