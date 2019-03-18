//
//  Movie.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let vote_count: Int
    let video: Bool
    let vote_average: Double
    let title: String
    let popularity: Double
    let poster_path: String?
    let original_language: String
    let original_title: String
    let genre_ids: [Int]
    let backdrop_path: String
    let adult: Bool
    let overview: String
    let release_date: String
}
