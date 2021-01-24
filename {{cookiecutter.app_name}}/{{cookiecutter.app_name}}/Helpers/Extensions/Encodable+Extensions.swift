//
//  Encodable+Extensions.swift
//  Stylee
//
//  Created by Morgan Le Gal on 20/08/2020.
//  Copyright © 2020 MadSeven. All rights reserved.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
}
