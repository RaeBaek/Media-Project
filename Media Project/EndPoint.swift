//
//  EndPoint.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/12.
//

import Foundation

enum EndPoint: String, CaseIterable {
    case day = "day"
    case week = "week"
    
    // https://api.themoviedb.org/3/trending/movie/week?api_key={api key}
    
    // day랑 week로 변경할 것
    var requestEndPoint: String {
        switch self {
        case .day: return "day?"
        case .week: return "week?"
        }
    }
    
}
