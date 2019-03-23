//
//  InstaMoviesTests.swift
//  InstaMoviesTests
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import XCTest
@testable import InstaMovies

class InstaMoviesTests: XCTestCase {
    
    func testMoviesFilter () {
        var movie1 = Movie(title: "movie 1", overview: "overview 1", release_date: "2020-02-02")
        movie1.createdByUser = false
        var movie2 = Movie(title: "movie 2", overview: "overview 2", release_date: "2020-02-02")
         movie2.createdByUser = false
        var movie3 = Movie(title: "movie 3", overview: "overview 3", release_date: "2020-02-02")
         movie3.createdByUser = false
        var movie4 = Movie(title: "movie 4", overview: "overview 4", release_date: "2020-02-02")
         movie4.createdByUser = false
        var movie5 = Movie(title: "movie 5", overview: "overview 5", release_date: "2020-02-02")
         movie5.createdByUser = false
        let userMovie = Movie(title: "userMovie", overview: "overview", release_date: "2020-02-02")
        
        
        let moviesArr: [Movie] = [
            movie1, movie2, movie3, movie4, movie5, userMovie
        ]
        
        let userMovies = moviesArr.filter(category: .my_movies)
        let otherMovies = moviesArr.filter(category: .all)
        
        XCTAssertEqual(userMovies.count, 1)
        XCTAssertEqual(userMovies[0].title, "userMovie")
        XCTAssertEqual(otherMovies.count, 5)
        XCTAssertEqual(otherMovies[0].title, "movie 1")
    }
    
    
    func testMoviesAPI () {
        let promise = expectation(description: "Data Not Null")
        
        var data: Data? = nil
        
        let url = URL(string: "http://api.themoviedb.org/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2&page=1")
        NetworkUtils.request(logTitle: "Movies", url!) {
            responseData, error in
            if let error = error {
                XCTFail("Error: \(error)")
            } else if let _ = responseData {
                data = responseData
                promise.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(data)
    }
}
