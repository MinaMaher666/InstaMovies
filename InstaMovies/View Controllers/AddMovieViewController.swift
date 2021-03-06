//
//  AddMovieViewController.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/19/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import UIKit

protocol NewMovieDelegate {
    func addNewMovie (movie: Movie)
    func cancel ()
}

class AddMovieViewController: UIViewController {
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var txtMovieTitle: UITextField!
    @IBOutlet weak var txtReleaseDate: UIDatePickerTextField!
    @IBOutlet weak var txtOverview: UITextView!
    
    var delegate: NewMovieDelegate?
    
    var poster: UIImage? {
        didSet {
            if let poster = poster {
                imgMoviePoster.alpha = 1
                imgMoviePoster.image = poster
            } else {
                imgMoviePoster.alpha = 0.5
                imgMoviePoster.image = UIImage(named: "image-placeholder")
            }
        }
    }
    
    var imageURL: URL? = nil {
        didSet {
            if let imageURL = imageURL {
                poster = imageURL.imageForUrl
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func validateFields () -> Bool {
        var isValid = txtMovieTitle.validate()
        isValid = txtReleaseDate.validate() && isValid
        isValid = txtOverview.validate() && isValid
        return isValid
    }
    
    @IBAction func addPoster() {
        showImagePickerAlert()
    }
    
    @IBAction func addNewMovie() {
        if validateFields () {
            let newMovie = Movie(title: txtMovieTitle.text!, poster_path: imageURL?.absoluteString,overview: txtOverview.text!, release_date: txtReleaseDate.text!)
            delegate?.addNewMovie(movie: newMovie)
            dismiss()
        }
    }
    
    
    @IBAction func cancel() {
        delegate?.cancel()
        dismiss()
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK:| ImagePickerAlert Extension
extension AddMovieViewController {
    func showImagePickerAlert () {
        presentPickerWith(sourceType: .photoLibrary)
    }
    
    fileprivate func presentPickerWith (sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        UIApplication.shared.keyWindow?.rootViewController?.present(imagePickerController, animated: true, completion: nil)
    }
}

// MARK:| ImagePicker Extension
extension AddMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageURL = info[.imageURL] as? URL
        picker.dismiss(animated: true, completion: nil)
    }
}
