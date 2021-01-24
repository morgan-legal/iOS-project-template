//
//  NetworkLogger.swift
//  Stylee
//
//  Created by Morgan Le Gal on 08/07/2020.
//  Copyright © 2020 madseven. All rights reserved.
//

import Foundation

class NetworkLogger {
    
    static func log(request: URLRequest) {
        print("\n---------------------------- ⏳ Requesting ----------------------------")
        defer { print("--------------------------------------------------------------------\n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
                        \(method): \(path)\(query.isEmpty ? "" : "?\(query)")
                        HOST: \(host)\n\n
                        """
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\nHTTP BODY:\n\(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
    
    static func log(httpMethod: HTTPMethod, response: HTTPURLResponse, data: Any? = nil) {
        print("\n---------------------------- ✅ Success ----------------------------")
        var logOutput = """
                        HOST   :  \(response.url?.host ?? "Unknown host")
                        PATH   :  \(response.url?.path ?? "unknown path")
                        METHOD :  \(httpMethod.rawValue)
                        """
        if let data = data {
            logOutput += "\nDATA   :  \n\(data)"
        }
        print(logOutput)
        print("--------------------------------------------------------------------\n")
    }
    
}
