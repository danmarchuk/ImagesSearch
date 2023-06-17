//
//  UIButton+Customization.swift
//  ImagesSearch
//
//  Created by Данік on 02/06/2023.
//

import UIKit

// MARK: - UIButton Extension
extension UIButton {
    func customizeButton() {
        self.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 56)
        self.tintColor = .white
        self.backgroundColor = UIColor(named: "purpleSearch")
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func addBorder() {
        self.layer.borderWidth = 1.0
        if #available(iOS 13.0, *) {
            self.layer.borderColor = UIColor.systemGray4.cgColor
        }
        self.layer.cornerRadius = 7
    }
    
    func addBlueBorder() {
        self.addBorder()
        self.layer.borderColor = UIColor.blue.cgColor
    }
}

extension UIView {
    func roundGrayView() {
        self.layer.cornerRadius = 7
        if #available(iOS 13.0, *) {
            self.backgroundColor = .systemGray4
        }
    }
}

extension UISearchBar {
    func makeTransparent() {
        self.backgroundImage = UIImage()
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.clear
        }
    }
}
