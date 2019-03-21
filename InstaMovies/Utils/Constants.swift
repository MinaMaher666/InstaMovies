//
//  Constants.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation

class Constants {
    private init () {}
    
    static let api_key = "acea91d2bff1c53e6604e4985b6989e2"
    
    // URL
    static let url_base_image = "http://image.tmdb.org/t/p/w185"
    static let url_movies = "http://api.themoviedb.org/3/discover/movie"
    
    // Query Params
    static let param_api_key = "api_key"
    static let param_page_key = "page"
    
    
    static let date_formate = "yyyy-MM-dd"
}
