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
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMovies()
    }

    
    
    func getMovies (page: Int = 1) {
        APIService.shared.movies (page: page) {
            movies, error in
            if let movies = movies {
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


extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == movies.count - 1 {
            currentPage += 1
            getMovies()
        }
        
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
