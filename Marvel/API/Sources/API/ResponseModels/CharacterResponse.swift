//
//  Character.swift
//  
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import Foundation
// MARK: - CharacterResponse
public struct CharacterResponse: Decodable {
    
    public struct Request: Encodable {
        public let offset: String
        
        public init(offset: String) {
            self.offset = offset
        }
    }
    
    public let code: Int?
    public let status, copyright, attributionText, attributionHTML: String?
    public let etag: String?
    public let data: DataClass?
}

// MARK: - DataClass
public struct DataClass: Decodable {
    public let offset, limit, total, count: Int?
    public let results: [CharacterItem]?
}

// MARK: - CharacterItem
public struct CharacterItem: Decodable {
    public let id: Int?
    public let name, resultDescription: String?
    public let modified: String?
    public let thumbnail: Thumbnail?
    public let resourceURI: String?
    public let comics, series: Comics?
    public let stories: Stories?
    public let events: Comics?
    public let urls: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - Comics
public struct Comics: Decodable {
    public let available: Int?
    public let collectionURI: String?
    public let items: [ComicsItem]?
    public let returned: Int?

    public init(available: Int?, collectionURI: String?, items: [ComicsItem]?, returned: Int?) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }
}

// MARK: - ComicsItem
public struct ComicsItem: Decodable {
    public let resourceURI: String?
    public let name: String?
}

// MARK: - Stories
public struct Stories: Decodable {
    public let available: Int?
    public let collectionURI: String?
    public let items: [StoriesItem]?
    public let returned: Int?
}

// MARK: - StoriesItem
public struct StoriesItem: Decodable {
    public let resourceURI: String?
    public let name: String?
    public let type: String?
}

// MARK: - Thumbnail
public struct Thumbnail: Decodable {
    public let path: String?
    public let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
public struct URLElement: Decodable {
    public let type: String?
    public let url: String?
}
