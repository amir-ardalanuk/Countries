//
//  File.swift
//  
//
//  Created by ardalan on 3/5/22.
//

import Foundation

struct RemoteNews: Decodable {
    let author: String?
    let title: String?
    let description: String
    let url: String
    let source: String
    let image: String?
    let category: String?
    let language: String?
    let country: String?
    let publishedAt: String
    
    enum CodingKeys: String, CodingKey {

        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case source = "source"
        case image = "image"
        case category = "category"
        case language = "language"
        case country = "country"
        case publishedAt = "published_at"
    }

}
