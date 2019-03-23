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
}

let imageCache = NSCache<AnyObject, AnyObject>()
extension MovieCell {
    func updatePoster () {
        imgPoster.image = UIImage(named: "image-placeholder")
        guard let path = movie.poster_path else { return }
        if let cachedImage = imageCache.object(forKey: path as AnyObject) as? UIImage {
            imgPoster.image = cachedImage
            return
        }
        
        NetworkUtils.imageForUrl(path) {
            image in
            // Validating the requested image is the image for the movie path not a reused cell movie path
            guard path == self.movie.poster_path else { return }
            if let image = image {
                imageCache.setObject(image, forKey: path as AnyObject)
                self.imgPoster.image = image
            }
        }
    }
}
