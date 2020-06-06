//
//  String+Extensions.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

// MARK: - Capitalization

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}

// MARK: - Boolean value

extension String {
    
    var boolValue: Bool? {
        switch lowercased() {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
}
