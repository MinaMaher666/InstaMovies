//
//  MoviesViewController.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    static let cellID = "movie-cell"
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMovies()
    }

    
    
    func getMovies () {
        APIService.shared.movies {
            movies, error in
            if let movies = movies {
                self.movies.removeAll()
                self.movies += movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if let error = error {
                self.presentMessage(message: error)
            }
        }
    }
}


extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: MoviesViewController.cellID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: MoviesViewController.cellID)
        }
        
        
        let currentMovie = movies[indexPath.row]
        cell.textLabel?.text = currentMovie.title
        cell.detailTextLabel?.text = currentMovie.release_date
        
        return cell
    }
}
