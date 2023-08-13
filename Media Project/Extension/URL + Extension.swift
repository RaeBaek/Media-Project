//
//  URL + Extension.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/12.
//

import Foundation

extension URL {
    static let baseUrl = "https://api.themoviedb.org/3/"
    
    static func makeMediaTypeString(_ mediaType: String) -> String {
        return baseUrl + "trending/" + mediaType
    }
    
    static func makeEndPointString(url: String, endpoint: String) -> String {
        return url + endpoint
    }
    
}
