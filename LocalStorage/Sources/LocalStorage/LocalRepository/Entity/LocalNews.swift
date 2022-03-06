//
//  File.swift
//  
//
//  Created by ardalan on 3/6/22.
//

import Foundation
import Core

extension News: Codable {
    public func encode(to encoder: Encoder) throws {
        
    }
    
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
        case published_at = "published_at"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let author = try values.decodeIfPresent(String.self, forKey: .author)
        let title = try values.decodeIfPresent(String.self, forKey: .title)
        let description = try values.decode(String.self, forKey: .description)
        let url = try values.decode(String.self, forKey: .url)
        let source = try values.decode(String.self, forKey: .source)
        let image = try values.decodeIfPresent(String.self, forKey: .image)
        let category = try values.decodeIfPresent(String.self, forKey: .category)
        let language = try values.decodeIfPresent(String.self, forKey: .language)
        let country = try values.decodeIfPresent(String.self, forKey: .country)
        let published_at = try values.decode(String.self, forKey: .published_at)
        let publishDate = try Date.make(withServerDate: published_at)
        self.init(author: author, title: title, description: description, url: url, source: source, image: image, category: category, language: language, country: country, publishedAt: publishDate)
        
    }
    
    
}
