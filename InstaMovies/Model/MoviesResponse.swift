//
//  MoviesResponse.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation

struct MoviesResponse: Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}
