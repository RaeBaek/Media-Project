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
    
    func requestTrendAPI(mediaType: MediaType, timeWindow: EndPoint, completionHandler: @escaping (TMDBTrending) -> ()) {
        //        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        // https://api.themoviedb.org/3/trending/movie/week?api_key={api key}
        let url = mediaType.requestURL + timeWindow.requestEndPoint + "api_key=" + APIKey.tmdbAPIKey
        
        print("Trend URL: \(url)")
        
        AF.request(url,
                   method: .get,
                   headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: TMDBTrending.self) { response in
                
                switch response.result {
                case .success(let value):
                    print("Trend API StatusCode:", response.response?.statusCode)
                    print(value)
                    completionHandler(value)
                    
                case .failure(let error):
                    print("Trend API StatusCode:", response.response?.statusCode)
                    print(error)
                }
            }
    }
    
    func requestMovieInfoAPI(credit: Int, completionHandler: @escaping (TMDBMovieInfo) -> ()) {
        //        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        // https://api.themoviedb.org/3/movie/569094?api_key={api_key}
        let url = URL.baseUrl + "movie/" + "\(credit)?" + "api_key=" + APIKey.tmdbAPIKey
        
        print("MovieInfo URL: \(url)")
        
        AF.request(url,
                   method: .get,
                   headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: TMDBMovieInfo.self) { response in
                
                switch response.result {
                case .success(let value):
                    print("MovieInfo API StatusCode:", response.response?.statusCode)
                    print(value)
                    print("무비 인포 값 확인!!")
                    completionHandler(value)
                    print("무비 인포 값 넘김!!")
                case .failure(let error):
                    print("MovieInfo API StatusCode:", response.response?.statusCode)
                    print("MovieInfo API ERROR: ", error)
                }
            }
        
    }
    
    func requestCreditAPI(mediaType: MediaType, credit: Int, completionHandler: @escaping (TMDBCredit) -> ()) {
        
        // credit URL
        // "https://api.themoviedb.org/3/movie/569094/credits?api_key=8c31e6329ccf3e537e1b066f9cdf25fb"
        let url = URL.baseUrl + "\(mediaType)/" + "\(credit)/credits" + "?api_key=" + APIKey.tmdbAPIKey
        
        print("Credit URL: \(url)")
        
        AF.request(url,
                   method: .get,
                   headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: TMDBCredit.self) { response in
                
                switch response.result {
                case .success(let value):
                    print("Credit API StatusCode:", response.response?.statusCode)
                    print(value)
                    print("크레딧 값 확인!!")
                    completionHandler(value)
                    print("크레딧 값 넘김!!")
                case .failure(let error):
                    print("Credit API StatusCode:", response.response?.statusCode)
                    print("Credit API ERROR: ", error)
                }
                
            }
        }
    
    func requestSimilarAPI(id: Int, completionHandler: @escaping (TMDBSimilar) -> ()) {
        // similar URL
        // https://api.themoviedb.org/3/movie/299534/similar
        let url = URL.baseUrl + "movie/" + "\(id)" + "/similar"
        
        AF.request(url,
                   method: .get,
                   headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: TMDBSimilar.self) { response in
                switch response.result {
                case .success(let value):
                    print("SimilarAPI statusCode:", response.response?.statusCode)
                    completionHandler(value)
                case .failure(let error):
                    print("SimilarAPI statusCode:", response.response?.statusCode)
                    print("Credit API ERROR: ", error)
                }
            }
        
    }
    
    func requestVedioAPI(id: Int, completionHandler: @escaping (TMDBVedio) -> ()) {
        // vedio URL
        // https://api.themoviedb.org/3/movie/299534/vedio
        let url = URL.baseUrl + "movie/" + "\(id)" + "/similar"
        
        AF.request(url,
                   method: .get,
                   headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: TMDBVedio.self) { response in
                switch response.result {
                case .success(let value):
                    print("SimilarAPI statusCode:", response.response?.statusCode)
                    completionHandler(value)
                case .failure(let error):
                    print("SimilarAPI statusCode:", response.response?.statusCode)
                    print("Credit API ERROR: ", error)
                }
            }
        
    }
}
