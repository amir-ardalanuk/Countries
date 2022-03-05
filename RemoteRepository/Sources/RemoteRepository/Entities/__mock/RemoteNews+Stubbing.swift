#if DEBUG
//
//  File.swift
//  
//
//  Created by ardalan on 3/5/22.
//

import Foundation

extension RemoteNews {
    static func stub(
        id: String = UUID().uuidString,
        author: String? = nil,
        title: String? = nil,
        description: String = "Description",
        url: String = "URL://",
        source: String = "Source",
        image: String? = "imageURL",
        category: String? = "Category",
        language: String? = "Language",
        country: String? = "Country",
        publishedAt: String = Date().description
    ) -> RemoteNews {
        .init(author: author, title: title, description: description, url: url, source: source, image: image, category: category, language: language, country: country, publishedAt: publishedAt)
    }
}

#endif
