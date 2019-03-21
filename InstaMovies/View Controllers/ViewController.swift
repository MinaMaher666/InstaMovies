//
//  ViewController.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblAppName: UILabel!
    @IBOutlet weak var logoYConstraint: NSLayoutConstraint!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logoYConstraint.constant = 0
        self.view.layoutIfNeeded()
        animate()
    }
    
    func animate () {
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.logoYConstraint.constant =  -100
            self.view.layoutIfNeeded()
        }) {
            _ in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.lblAppName.alpha = 1
            }) {
                _ in
                self.launchMainVC()
            }
        }
    }
    
    func launchMainVC () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let window = UIApplication.shared.keyWindow
            window?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationController")
            window?.makeKeyAndVisible()
        })
    }
}
