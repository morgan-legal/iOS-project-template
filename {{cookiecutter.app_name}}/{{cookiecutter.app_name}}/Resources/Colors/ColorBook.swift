//
//  ColorBook.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

struct ColorBook {
    
    static let background: UIColor = ColorName.background.associatedColor
    
    
    // MARK: Color name list
    
    private enum ColorName: String {
        case background
        
        
        // Variables
        
        var associatedColor: UIColor {
            return safelyUnwrapColor(color: UIColor(named: self.rawValue))
        }
        
        // Helper methods
        
        private func safelyUnwrapColor(color: UIColor?) -> UIColor {
            guard let color = color else {
                return .white
            }
            return color
        }
    }
    
}
