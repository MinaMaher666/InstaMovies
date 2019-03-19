//
//  MoviesViewModel.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/19/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation

class MoviesViewModel {
    var movies: [Movie] = []
    
    var moviesCount: Int {
        return movies.count
    }
    
    var page: Int = 1 {
        didSet {
            getMovies(page: page)
        }
    }
    
    var moviesObserver: (() -> ())?
    var insertMoviesObserver: (([Int]) -> ())?
    var errorObserver: ((String) -> ())?
    
    init(moviesObserver: @escaping () -> ()) {
        self.moviesObserver = moviesObserver
        getMovies()
    }
    
    func movieForIndex (_ index: Int) -> Movie {
        return movies[index]
    }
    
    func getMovies (page: Int = 1) {
        APIService.shared.movies (page: page) {
            movies, error in
            if let movies = movies {
                self.movies += movies
                self.moviesObserver?()
            } else if let error = error {
                self.errorObserver?(error)
            }
        }
    }
    
    func insertMovie (movie: Movie, at index : Int = 0) {
        movies.insert(movie, at: index)
        insertMoviesObserver?([index])
    }
}
