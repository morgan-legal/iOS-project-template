//
//  Double+Extensions.swift
//  Stylee
//
//  Created by Morgan Le Gal on 15/06/2020.
//  Copyright © 2020 MadSeven. All rights reserved.
//

import Foundation

extension Double {
    
    var trimmedString: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
}

// Amounts

extension Double {

    func getLocalizedAmount(currencyCode: String) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.currencyCode = currencyCode
        return formatter.string(for: self)
    }
    
}
