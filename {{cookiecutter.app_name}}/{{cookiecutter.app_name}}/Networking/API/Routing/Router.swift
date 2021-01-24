//
//  Router.swift
//  Stylee
//
//  Created by Morgan Le Gal on 08/07/2020.
//  Copyright © 2020 madseven. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointDescriptor>: RouterDescriptor {
    
    private var task: URLSessionTask?
    
    private var isMocked: Bool = false
    
    // MARK: - Initializer
    
    init(isMocked: Bool? = false) {
        self.isMocked = isMocked ?? false
    }
    
    // MARK: - Exposed methods
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            NetworkLogger.log(request: request)
            task = session.dataTask(with: request) { data, response, error in
                completion(data, response, error)
            }
        } catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
    
    // MARK: - Private methods
    
    // swiftlint:disable function_body_length
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var serverURL: URL = route.baseURL
        if isMocked {
            serverURL = Environment.mockedServerUrl
        }

        var request = URLRequest(url: serverURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        // Handles the request timeout
        request.timeoutInterval = 30
        
        let platform = Environment.platform
        let deviceIdentifier = SharedKeychain.instance.deviceIdentifier ?? ""
        
        // UUID, Platform & Locale
        request.setValue(deviceIdentifier, forHTTPHeaderField: HTTPHeaderKeys.uuid)
        request.setValue(platform, forHTTPHeaderField: HTTPHeaderKeys.platform)
        request.setValue(Locale.current.identifier, forHTTPHeaderField: HTTPHeaderKeys.locale)
        
        // Access Token
        if let accessToken = SharedKeychain.instance.accessToken {
            request.setValue(accessToken, forHTTPHeaderField: HTTPHeaderKeys.accessToken)
        }
        
        do {
            switch route.task {
            
            case let .multipartDataRequest(data, boundary):
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                request.httpBody = data
                
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case let .requestParameters(bodyParameters,
                                        bodyEncoding,
                                        urlParameters):
                
                try configureParameters(bodyParameters: bodyParameters,
                                        bodyEncoding: bodyEncoding,
                                        urlParameters: urlParameters,
                                        request: &request)
                
            case let .requestParametersAndHeaders(bodyParameters,
                                                  bodyEncoding,
                                                  urlParameters,
                                                  additionalHeaders):
                
                addAdditionalHeaders(additionalHeaders, request: &request)
                try configureParameters(bodyParameters: bodyParameters,
                                        bodyEncoding: bodyEncoding,
                                        urlParameters: urlParameters,
                                        request: &request)
            }
            
            // HMAC Signature
            // We need to do it here because of changes on the request with the parameters above
            let urlString = request.url?.absoluteString ?? ""
            let apiKey = Environment.apiKey
        
            var parameters = ""
            if route.httpMethod == .get || route.httpMethod == .delete {
                let params = urlString.split(separator: "?")
                if params.count > 1 {
                    parameters = String(params[1])
                }
            } else {
                if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
                    parameters = bodyString
                }
            }

            let clearHmac = "\(urlString)\(apiKey)\(platform)\(deviceIdentifier)\(route.calculateHMACWithParameters ? parameters : "")"
            let base64Hmac = clearHmac.toBase64()
            let hmac = base64Hmac.hmac(algorithm: .sha256, key: apiKey)
            request.setValue(hmac, forHTTPHeaderField: HTTPHeaderKeys.hmac)
            
            return request
        } catch {
            throw error
        }
    }
    
    
    // MARK: Helpers
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else {
            return
        }
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
