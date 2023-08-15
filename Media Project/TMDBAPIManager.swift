//
//  TMDBAPIManager.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/12.
//

import UIKit
import Alamofire
import SwiftyJSON

class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    
    private init() { }
    
    let header: HTTPHeaders = [
        "accept": "application/json",
        "Authorization": "Bearer \(APIKey.readAccessToken)"
    ]
    
    func requestTrendAPI(mediaType: MediaType, timeWindow: EndPoint, completionHandler: @escaping (JSON) -> ()) {
//        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        // https://api.themoviedb.org/3/trending/movie/week?api_key={api key}
        let url = mediaType.requestURL + timeWindow.requestEndPoint + "api_key=" + APIKey.tmdbAPIKey
        
        print("Trend URL: \(url)")
        
        AF.request(url,
                   method: .get,
                   headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // 이 부분이 매우 중요!! 컴플리션 핸들러!!
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestCreditAPI(mediaType: MediaType, credit: Int, completionHandler: @escaping (JSON) -> ()) {

        // credit URL
        // "https://api.themoviedb.org/3/movie/569094/credits?api_key=8c31e6329ccf3e537e1b066f9cdf25fb"
        let url = URL.baseUrl + "\(mediaType)/" + "\(credit)/credits" + "?api_key=" + APIKey.tmdbAPIKey
        
        print("Credit URL: \(url)")
        
        AF.request(url,
                   method: .get,
                   headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // 이 부분이 매우 중요!! 컴플리션 핸들러!!
                completionHandler(json)
                print("creditAPI 성공성공!")
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
