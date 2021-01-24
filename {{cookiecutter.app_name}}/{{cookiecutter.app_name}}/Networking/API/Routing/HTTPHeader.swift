//
//  HTTPHeader.swift
//  Stylee
//
//  Created by Morgan Le Gal on 17/07/2020.
//  Copyright © 2020 MadSeven. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]

struct HTTPHeaderKeys {
    static let locale = "LOCALE"
    static let hmac = "HMAC"
    static let accessToken = "ACCESS-TOKEN"
    static let uuid = "GAID"
    static let platform = "PLATFORM"
}
