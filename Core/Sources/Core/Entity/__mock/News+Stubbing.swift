//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation

public extension News {
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
        publishedAt: Date = Date()
    ) -> News {
        .init(author: author, title: title, description: description, url: url, source: source, image: image, category: category, language: language, country: country, publishedAt: publishedAt)
    }
}
