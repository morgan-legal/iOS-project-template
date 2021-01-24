//
//  UIAlertController+Extensions.swift
//  Stylee
//
//  Created by Morgan Le Gal on 18/12/2020.
//  Copyright © 2020 MadSeven. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    func configure() {
        pruneNegativeWidthConstraints()
        view.tintColor = R.color.primaryTextColor()
        setTitle(font: FontBook.medium.of(size: 16), color: R.color.emphasizedTextColor())
        setMessage(font: FontBook.light.of(size: 15), color: R.color.secondaryTextColor())
    }
    
    private func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
    
    private func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = message else {
            return
        }
        let attributedString = NSMutableAttributedString(string: message)
        
        if let font = font {
            attributedString.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: message.utf8.count))
        }
        
        if let color = color {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: color], range: NSRange(location: 0, length: message.utf8.count))
        }
        
        setValue(attributedString, forKey: "attributedMessage")
    }
    
    private func setTitle(font: UIFont?, color: UIColor?) {
        guard let title = title else {
            return
        }
        let attributedString = NSMutableAttributedString(string: title)
        
        if let font = font {
            attributedString.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: title.utf8.count))
        }
        
        if let color = color {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: color], range: NSRange(location: 0, length: title.utf8.count))
        }
        
        setValue(attributedString, forKey: "attributedTitle")
    }

}
