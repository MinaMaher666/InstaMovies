//
//  MoviesViewModel.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/19/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation

enum MovieCategory: Int {
    case all = 1
    case my_movies
    case both
}

class MoviesViewModel {
    var response: MoviesResponse? {
        didSet {
            if let response = response {
                movies += response.results
                self.refreshMovies()
            }
        }
    }
    var movies: [Movie] = []
    var moviesByCategories: [Movie]
    var category: MovieCategory = .all {
        didSet {
            refreshMovies()
        }
    }
    
    var moviesCount: Int {
        return moviesByCategories.count
    }
    
    var shouldPaginate: Bool {
        return  category != .my_movies && (page < response?.total_pages ?? 0) && !isLoading
    }
    
    var page: Int = 1 {
        didSet {
            getMovies(page: page)
        }
    }
    
    var startLoadingMovies: (() -> ())?
    var moviesObserver: (() -> ())?
    var errorObserver: ((String) -> ())?
    
    var isLoading: Bool = false
    
    init(moviesObserver: @escaping () -> ()) {
        self.moviesObserver = moviesObserver
        moviesByCategories = movies
        getMovies()
    }
    
    func movieForIndex (_ index: Int) -> Movie {
        return moviesByCategories[index]
    }
    
    func getMovies (page: Int = 1) {
        isLoading = true
        startLoadingMovies?()
        APIService.shared.movies (page: page) {
            response, error in
            self.isLoading = false
            if let response = response {
                self.response = response
            } else if let error = error {
                self.errorObserver?(error)
            }
        }
    }
    
    func insertMovie (movie: Movie, at index : Int = 0) {
        movies.insert(movie, at: index)
        refreshMovies()
    }
    
    func refreshMovies () {
        moviesByCategories.removeAll()
        moviesByCategories += movies.filter (category: category)
        moviesObserver?()
    }
}


extension Collection where Element == Movie {
    func filter (category: MovieCategory) -> [Movie] {
        switch category {
        case .both:
            return self as! [Movie]
        case .all:
            return filter {!($0.createdByUser ?? false)}
        case .my_movies:
            return filter {$0.createdByUser ?? false}
        }
    }
}
