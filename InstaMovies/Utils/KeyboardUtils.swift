//
//  KeyboardUtils.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/21/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation
import UIKit

class KeyboardUtils {
    static var shared = KeyboardUtils()
    lazy var windowTapGesture = {
        return UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    }()
    
    
    private init () {}
    
    func setup () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow (notification: Notification) {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addGestureRecognizer(windowTapGesture)
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if window.frame.origin.y == 0{
                window.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc private func keyboardWillHide (notification: Notification) {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.removeGestureRecognizer(windowTapGesture)
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if window.frame.origin.y != 0 {
                window.frame.origin.y = 0
            }
        }
    }
    
    static func addDoneButtonOnKeyboard(textField: UITextField? = nil, textView: UITextView? = nil) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hideKeyboard))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textField?.inputAccessoryView = doneToolbar
        textView?.inputAccessoryView = doneToolbar
    }
    
    @objc static func hideKeyboard() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.endEditing(true)
    }
    
    @objc func hideKeyboard() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.endEditing(true)
    }
}

extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        KeyboardUtils.addDoneButtonOnKeyboard(textField: self)
    }
}

extension UITextView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        KeyboardUtils.addDoneButtonOnKeyboard(textView: self)
    }
}
