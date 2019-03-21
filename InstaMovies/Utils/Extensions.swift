//
//  Extensions.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    func presentMessage (message: String) {
        let alert = GeneralUtils.presentSimpleAlert(message: message)
        present(alert, animated: true, completion: nil)
    }
}


extension UITextField {
    func showError () {
        updateErrorView(isError: true)
        shake()
    }
    
    func hideError () {
        updateErrorView(isError: false)
    }
    
    func updateErrorView (isError: Bool) {
        self.rightView = isError ? UIImageView(image: UIImage(named: "txt-error")) : nil
        self.rightViewMode = isError ? .always : .never
    }
    
    func shake() {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = 4
        animation.duration = 0.2/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: CGFloat(-5), y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: CGFloat(5), y: self.center.y))
        layer.add(animation, forKey: "shake")
    }
    
    func validate() -> Bool {
        if text?.count ?? 0 < 1 {
            showError()
            return false
        } else {
            hideError()
            return true
        }
    }
    
    func validate(with: ((String?) -> Bool)) -> Bool {
        if !with(text) {
            showError()
            return false
        } else {
            hideError()
            return true
        }
    }
}

extension UITextView {
    func showError () {
        shake()
    }
    
    func shake() {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = 4
        animation.duration = 0.2/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: CGFloat(-5), y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: CGFloat(5), y: self.center.y))
        layer.add(animation, forKey: "shake")
    }
    
    func validate() -> Bool {
        if text?.count ?? 0 < 1 {
            showError()
            return false
        } else {
            return true
        }
    }
    
    func validate(with: ((String?) -> Bool)) -> Bool {
        if !with(text) {
            showError()
            return false
        } else {
            return true
        }
    }
}

extension URL {
    var imageForUrl: UIImage {
        guard let data = try? Data(contentsOf: self) else {return UIImage(named: "image-placeholder")!}
        return UIImage(data: data) ?? UIImage(named: "image-placeholder")!
    }
}
