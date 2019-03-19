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
    
    var moviesViewModel: MoviesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instantiateViewModel()
    }
    
    func instantiateViewModel() {
        moviesViewModel = MoviesViewModel (moviesObserver: {
            // weak self To Prevent Retaining of self
            [weak self] in
            self?.tableView.reloadData()
        })
        
        moviesViewModel.errorObserver = {
            [weak self] error in
            self?.presentMessage(message: error)
        }
        
        moviesViewModel.insertMoviesObserver = {
            [weak self] rows in
            let indexPaths = rows.map {IndexPath(row: $0, section: 0)}
            self?.tableView.insertRows(at: indexPaths, with: .top)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == "newMovieSegue" {
                let destination = segue.destination as! AddMovieViewController
                destination.delegate = self
            }
        }
    }
}


extension MoviesViewController: NewMovieDelegate {
    func cancel() {
    }
    
    func addNewMovie(movie: Movie) {
        moviesViewModel.insertMovie(movie: movie)
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesViewModel.moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        paginateIfRequired(indexPath.row)
        
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: MoviesViewController.cellID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: MoviesViewController.cellID)
        }
        
        return bindCell(cell: cell, index: indexPath.row)
    }
    
    func paginateIfRequired (_ index: Int) {
        if index == moviesViewModel.moviesCount - 1 {
            moviesViewModel.page += 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MoviesViewController {
    func bindCell (cell: UITableViewCell, index: Int) -> UITableViewCell {
        cell.backgroundColor = .clear
        let currentMovie = moviesViewModel.movieForIndex(index)
        cell.textLabel?.text = currentMovie.title
        cell.imageView?.image = UIImage(named: "logo")
        if currentMovie.createdByUser ?? false {
            cell.imageView?.image = UIImage(named: "logo")
        } else if let posterPath = currentMovie.poster_path{
            NetworkUtils.imageForUrl(posterPath) {
                image in
                if let image = image {
                    DispatchQueue.main.async {
                        cell.imageView?.image = image
                    }
                }
            }
        }
        cell.detailTextLabel?.text = currentMovie.release_date
        return cell
    }
}
