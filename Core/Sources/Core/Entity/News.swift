//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation

public struct News: Hashable {
    public let author: String?
    public let title: String?
    public let description: String
    public let url: String
    public let source: String
    public let image: String?
    public let category: String?
    public let language: String?
    public let country: String?
    public let publishedAt: Date
    
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
