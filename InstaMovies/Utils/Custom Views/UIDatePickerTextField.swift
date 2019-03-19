//
//  UIDatePickerTextField.swift
//  InstaMovies
//
//  Created by Mina Maher on 3/19/19.
//  Copyright © 2019 Mina Maher. All rights reserved.
//

import Foundation
import UIKit

class UIDatePickerTextField: UITextField {
    let datePicker = UIDatePicker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(showDatePickerAction), for: .editingDidBegin)
    }
    
    @objc func showDatePickerAction () {
        showDatePicker()
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        inputAccessoryView = toolbar
        inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.date_formate
        text = formatter.string(from: datePicker.date)
        endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        endEditing(true)
    }
}
