//
//  FontBook.swift
//  {{cookiecutter.app_name}}
//
//  Created by Morgan Le Gal on 06/06/2020.
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

/// Font book
enum FontBook: String {
    
    // Cases
    case thin
    case light
    case regular
    case medium
    case bold
    case heavy
    
    /// Method to get the font of a given size associated with a specific case
    ///
    /// - Parameter size: the font size
    /// - Returns: the UIFont
    func of(size: CGFloat) -> UIFont {
        switch self {
        case .thin: return UIFont.systemFont(ofSize: size, weight: .thin)
        case .light: return UIFont.systemFont(ofSize: size, weight: .light)
        case .regular: return UIFont.systemFont(ofSize: size)
        case .medium: return UIFont.systemFont(ofSize: size, weight: .medium)
        case .bold: return UIFont.systemFont(ofSize: size, weight: .bold)
        case .heavy: return UIFont.systemFont(ofSize: size, weight: .bold)
        }
    }
    
}
