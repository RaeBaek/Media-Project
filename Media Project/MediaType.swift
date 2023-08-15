//
//  EndPoint.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/12.
//

import Foundation

enum MediaType: String, CaseIterable {
    case all = "all"
    case movie = "movie"
    case tv = "tv"
    case person = "person"
    
    // https://api.themoviedb.org/3/trending/movie/week?api_key={api key}
    // https://api.themoviedb.org/3/movie/movie_id/credits?language=en-US
    
    var requestURL: String {
        switch self {
        case .all: return URL.makeMediaTypeString("all/")
        case .movie: return URL.makeMediaTypeString("movie/")
        case .tv: return URL.makeMediaTypeString("tv/")
        case .person: return URL.makeMediaTypeString("person/")
        }
    }

}
