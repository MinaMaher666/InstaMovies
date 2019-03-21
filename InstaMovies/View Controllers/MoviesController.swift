//
//  MoviesViewController.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import UIKit

class MoviesController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isLoading: Bool = false {
        didSet {
            collectionView.reloadData()
        }
    }
    
    static let cellNibName = "MovieCell"
    static let loadingCellNibName = "LoadingCell"
    static let cellID = "movie-cell"
    static let loadingCellID = "loading-cell"
    static let itemsPerRow: CGFloat = 2
    static let itemWidth = {
        return (UIScreen.main.bounds.width / itemsPerRow)
    }()
    
    static let itemHeight = {
        return (UIScreen.main.bounds.height / 2)
    }()
    
    var moviesViewModel: MoviesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        instantiateViewModel()
    }
    
    func instantiateViewModel() {
        moviesViewModel = MoviesViewModel (moviesObserver: {
            // weak self To Prevent Retaining of self
            [weak self] in
            self?.collectionView.reloadData()
            self?.isLoading = false
        })
        
        moviesViewModel.errorObserver = {
            [weak self] error in
            self?.presentMessage(message: error)
        }
        
        moviesViewModel.startLoadingMovies = {
            [weak self] in
            self?.isLoading = true
        }
    }
    
    func setupCollectionView () {
        collectionView.register(UINib(nibName: MoviesController.cellNibName, bundle: nil), forCellWithReuseIdentifier: MoviesController.cellID)
        collectionView.register(UINib(nibName: MoviesController.loadingCellNibName, bundle: nil), forCellWithReuseIdentifier: MoviesController.loadingCellID)
    }
    
    @IBAction func changeCategory(_ sender: UISegmentedControl) {
        moviesViewModel.category = MovieCategory(rawValue: sender.selectedSegmentIndex + 1) ?? .all
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


extension MoviesController: NewMovieDelegate {
    func cancel() {
    }
    
    func addNewMovie(movie: Movie) {
        moviesViewModel.insertMovie(movie: movie)
    }
}

extension MoviesController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == moviesViewModel.moviesCount {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesController.loadingCellID, for: indexPath) as! LoadingCell
            return cell
        } else {
            paginateIfRequired(indexPath.item)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesController.cellID, for: indexPath) as! MovieCell
            cell.movie = moviesViewModel.movieForIndex(indexPath.item)
            return cell
        }
    }
    
    func paginateIfRequired (_ index: Int) {
        if index == moviesViewModel.moviesCount - 1 && moviesViewModel.shouldPaginate {
            moviesViewModel.page += 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesViewModel.moviesCount + (isLoading ? 1 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == moviesViewModel.moviesCount {
            return CGSize(width: UIScreen.main.bounds.width, height: 48)
        } else {
            return CGSize(width: MoviesController.itemWidth, height: MoviesController.itemHeight)
        }
    }
}
