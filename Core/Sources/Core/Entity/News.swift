//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation

public struct News: Hashable {
    let author: String?
    let title: String?
    let description: String
    let url: String
    let source: String
    let image: String?
    let category: String?
    let language: String?
    let country: String?
    let publishedAt: Date
    
    public init(author: String?, title: String?, description: String, url: String, source: String, image: String?, category: String?, language: String?, country: String?, publishedAt: Date) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.source = source
        self.image = image
        self.category = category
        self.language = language
        self.country = country
        self.publishedAt = publishedAt
    }
}
