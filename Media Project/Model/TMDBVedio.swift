//
//  TMDBVedio.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/21.
//

import Foundation

// MARK: - Welcome
struct TMDBVedio: Codable {
    let id: Int
    let results: [vedioResult]?
}

// MARK: - Result
struct vedioResult: Codable {
    let iso639_1, iso3166_1: String?
    let key: String?
    let name: String?
    let site: String?
    let size: Int?
    let type: TypeEnum
    let official: Bool?
    let publishedAt: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

enum TypeEnum: String, Codable {
    case behindTheScenes = "Behind the Scenes"
    case bloopers = "Bloopers"
    case clip = "Clip"
    case featurette = "Featurette"
    case teaser = "Teaser"
    case trailer = "Trailer"
}
