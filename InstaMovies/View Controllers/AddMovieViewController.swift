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
            let newMovie = Movie(title: txtMovieTitle.text!, overview: txtOverview.text!, release_date: txtReleaseDate.text!, vote_average: 10.0)
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
        if UIImagePickerController.isSourceTypeAvailable(.camera) &&
            UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {_ in
                self.presentPickerWith(sourceType: .camera)
            }))
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {_ in
                self.presentPickerWith(sourceType: .photoLibrary)
            }))
            
            present(alert, animated: true, completion: nil)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            presentPickerWith(sourceType: .camera)
        } else if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            presentPickerWith(sourceType: .photoLibrary)
        }
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
        let image = info[.originalImage] as! UIImage
        poster = image
        picker.dismiss(animated: true, completion: nil)
    }
}
