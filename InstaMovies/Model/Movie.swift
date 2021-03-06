//
//  Movie.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct Movie: Decodable {
    var id: Int
    var title: String
    var poster_path: String?
    var overview: String
    var release_date: String
    
    var createdByUser: Bool? = false
    
    init(title: String, poster_path: String? = nil, overview: String, release_date: String) {
        self.id = 0
        self.createdByUser = true
        self.title = title
        self.poster_path = poster_path
        self.overview = overview
        self.release_date = release_date
    }
}

extension Movie {
    // Image From Gallery
    func imageFromLocalFileUrl () -> UIImage? {
        guard createdByUser ?? false, let poster_path = poster_path, let imageURL = URL(string: poster_path) else { return UIImage(named: "image-placeholder") }
        return imageURL.imageForUrl
    }
}

