//
//  Int+Extensions.swift
//  Stylee
//
//  Created by Morgan Le Gal on 15/10/2020.
//  Copyright © 2020 MadSeven. All rights reserved.
//

import Foundation

extension Array where Element == Int {
    func toStringArray() -> [String] {
        return compactMap { String($0) }
    }
}
