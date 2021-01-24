//
//  RouterDescriptor.swift
//  Stylee
//
//  Created by Morgan Le Gal on 08/07/2020.
//  Copyright © 2020 madseven. All rights reserved.
//

import Foundation

typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol RouterDescriptor: class {
    
    associatedtype EndPoint: EndPointDescriptor
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
    
}
