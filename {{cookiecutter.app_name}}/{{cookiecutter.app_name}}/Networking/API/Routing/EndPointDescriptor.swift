//
//  EndPointDescriptor.swift
//  Stylee
//
//  Created by Morgan Le Gal on 07/07/2020.
//  Copyright © 2020 madseven. All rights reserved.
//

import Foundation

protocol EndPointDescriptor {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
