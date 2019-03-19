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
