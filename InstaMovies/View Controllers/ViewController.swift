//
//  ViewController.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getMovies () {
        APIService.shared.movies {
            movies, error in
            
            if let movies = movies {
                
            } else if let error = error {
                self.presentMessage(message: error)
            }
        }
    }
    
}
