//
//  GeneralUtils.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/18/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation
import UIKit

class GeneralUtils {
    private init () {}
    
    static func presentSimpleAlert (title: String = "InstaMovies", message: String, actions: [UIAlertAction] = []) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.isEmpty {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        } else {
            actions.forEach {alert.addAction($0)}
        }
        return alert
    }
}
