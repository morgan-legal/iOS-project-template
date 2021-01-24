//
//  HTTPTask.swift
//  Stylee
//
//  Created by Morgan Le Gal on 07/07/2020.
//  Copyright © 2020 madseven. All rights reserved.
//

import Foundation

enum HTTPTask {
    
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)

    case multipartDataRequest(data: Data, boundary: String)
}
