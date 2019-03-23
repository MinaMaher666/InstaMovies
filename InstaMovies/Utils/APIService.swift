//
//  NetworkUtils.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation

typealias MoviesCompletion = ((MoviesResponse?, String?) -> ())

class APIService {
    static var shared = APIService()
    
    private init () {}
    
    func movies (logTitle: String = "Movies", page: Int = 1, completion: @escaping MoviesCompletion) {
        let params: [String:Any] = [
            Constants.param_api_key: Constants.api_key,
            Constants.param_page_key: page
        ]
        
        // Gets The url with the parameters
        let urlWithParamsString = NetworkUtils.appendQueryParamsToUrl(Constants.url_movies, params: params)
        guard let url = URL(string: urlWithParamsString) else { return }
        
        NetworkUtils.request(logTitle: logTitle, url) {
            data, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    completion(response, nil)
                } catch {
                    print("\(NetworkUtils.responseLog(for: logTitle))Decoding Error: \(error)\(NetworkUtils.responseLog(for: logTitle))")
                    completion(nil, "Something went wrong")
                }
            } else if let error = error {
                completion(nil, error)
            }
        }
        
    }
}
