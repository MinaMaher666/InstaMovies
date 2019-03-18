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
