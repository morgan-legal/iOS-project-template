//
//  UIView+Extensions.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

extension UIView {

    func addShadow(color: UIColor, radius: CGFloat, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
}
