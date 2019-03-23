//
//  NetworkUtils.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation
import UIKit.UIImage

typealias RequestCompletion = (Data?, String?) -> ()
class NetworkUtils {
    private init () {}
    
    
    static func requestLog (for title: String = "") -> String {
        return "\n============ \(title.uppercased()) REQUEST ============\n"
    }
    
    static func responseLog (for title: String = "") -> String {
        return "\n============ \(title.uppercased()) RESPONSE ============\n"
    }
    
    static func appendQueryParamsToUrl (_ url: String, params: [String:Any]) -> String {
        var basicUrl = url + "?"
        basicUrl += params.reduce("") {"\($0)&\($1.key)=\($1.value)"}
        return basicUrl
    }
    
    static func request (logTitle: String = "", _ url: URL, completion: @escaping RequestCompletion) {
        
        print("\(requestLog(for: logTitle))Requesting Url: \(url.absoluteString)\(requestLog(for: logTitle))")
        
        let task = URLSession.shared.dataTask(with: url) {
            data, _, error in
            if let data = data {
                // Logging server response
                if let dataString = String(data: data, encoding: .utf8) {
                     print("\(responseLog(for: logTitle))\(dataString)\(responseLog(for: logTitle))")
                }
                
                DispatchQueue.main.async {
                    completion(data, nil)
                }
                
            } else if let error = error {
                // Logging error
                print("\(responseLog(for: logTitle))\(error)\(responseLog(for: logTitle))")
                
                DispatchQueue.main.async {
                    completion(nil, "Network Error")                    
                }
            }
        }
        
        task.resume()
    }
    
    
    static func imageForUrl (_ path: String, completion: @escaping (UIImage?) -> ()) {
        let urlString = Constants.url_base_image + path
        guard let url = URL(string: urlString) else { completion(nil); return }
        request(logTitle: "DownloadImage", url) {
            data, _ in
            if let data = data {
                let image = UIImage(data: data)
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
