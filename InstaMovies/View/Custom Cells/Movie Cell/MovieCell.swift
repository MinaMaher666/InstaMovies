//
//  MovieCell.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/20/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation
import UIKit.UICollectionViewCell

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    var movie: Movie! {
        didSet {
            if let movie = movie {
                lblTitle.text = movie.title
                lblReleaseDate.text = movie.release_date
                lblOverview.text = movie.overview
                updatePoster()
            }
        }
    }
    
    func updatePoster () {
        imgPoster.image = UIImage(named: "image-placeholder")
        if movie.createdByUser ?? false {
            if let imageURL = URL(string: movie.poster_path ?? "") {
                if let data = try? Data(contentsOf: imageURL as URL) {
                    let image = UIImage(data: data)
                    imgPoster.image = image
                } else {
                     imgPoster.image = UIImage(named: "image-placeholder")
                }
            }
        } else if let posterPath = movie.poster_path{
            NetworkUtils.imageForUrl(posterPath) {
                image in
                if let image = image {
                    self.imgPoster.image = image
                }
            }
        }
    }
}
