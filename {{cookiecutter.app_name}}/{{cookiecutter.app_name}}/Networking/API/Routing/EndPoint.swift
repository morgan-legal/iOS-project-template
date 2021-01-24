//
//  EndPoint.swift
//  Stylee
//
//  Created by Morgan Le Gal on 08/07/2020.
//  Copyright © 2020 madseven. All rights reserved.
//

import Foundation

enum EndPoint {
    // Get
    case getPosts(page: Int, styleId: Int)
    
    // Post
    case searchPosts(page: Int, body: SearchPostsBody)
    
    // Delete
    case deleteUser
}

// MARK: EndPointDescriptor

extension EndPoint: EndPointDescriptor {
    
    // MARK: - Server URL
    
    var baseURL: URL {
        return Environment.serverUrl
    }
    
    var path: String {
        switch self {
        // GET
        case .getPosts: return "/posts"
            
        // POST
        case .searchPosts: return "/search"
            
        // DELETE
        case .deleteUser: return "/user"
        }
    }
    
    // MARK: - HTTP Method
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getPosts:
            return .get
            
        case .searchPosts:
            return .post
            
        case .deleteUser:
            return .delete
        }
    }
    
    // MARK: - HTTP Task (parameters)
    
    var task: HTTPTask {
        switch self {

        case let .getPosts(page, styleId):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page": page,
                                                      "style": styleId])
                    
        case let .searchPosts(page, body):
            var dict = body.dictionary
            dict?["page"] = page
            return .requestParameters(bodyParameters: dict, bodyEncoding: .jsonEncoding, urlParameters: nil)

        default: return .request
        }
    }
    
    // MARK: - HTTP Headers
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
