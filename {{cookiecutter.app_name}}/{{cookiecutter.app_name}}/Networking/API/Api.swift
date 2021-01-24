//
//  Api.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

protocol Api {
    
    var router: Router<EndPoint> { get }
    
    // GET
    func getPosts(page: Int, styleId: Int, completion: @escaping (_ posts: [Post]?, _ hasMoreContentAvailable: Bool, _ error: String?) -> Void)

    // POST
    func searchPosts(page: Int, body: SearchPostsBody, completion: @escaping (_ posts: [Post]?, _ hasMoreContentAvailable: Bool, _ error: String?) -> Void)

    // DELETE
    func deleteUser(completion: @escaping (_ error: String?) -> Void)
}

// MARK: - API Default Implementation

extension Api {
    
    // GET

    func getPosts(page: Int, styleId: Int, completion: @escaping (_ posts: [Post]?, _ hasMoreContentAvailable: Bool, _ error: String?) -> Void) {
        performRequest(router: router, route: .getPosts(page: page, styleId: styleId), completion: completion)
    }
    
    // POST
 
    func searchPosts(page: Int, body: SearchPostsBody, completion: @escaping (_ posts: [Post]?, _ hasMoreContentAvailable: Bool, _ error: String?) -> Void) {
        performRequest(router: router, route: .searchPosts(page: page, body: body), completion: completion)
    }
    
    // DELETE
    
    func deleteUser(completion: @escaping (_ error: String?) -> Void) {
        performRequest(router: router, route: .deleteUser, completion: completion)
    }

    
    // MARK: - Helpers
    
    private func performRequest<T: Decodable>(router: Router<EndPoint>,
                                              route: EndPoint,
                                              decoder: JSONDecoder = JSONDecoder(),
                                              completion: @escaping (_ response: T?, _ error: String?) -> Void) {
        
        router.request(route) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            let result = self.handleNetworkResponse(response)
            
            switch result {
            case .success:
                guard let responseData = data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    NetworkLogger.log(httpMethod: route.httpMethod, response: response, data: jsonData)
                    let data = try decoder.decode(T.self, from: responseData)
                    completion(data, nil)
                } catch {
                    log.error(error)
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                if response.statusCode == 401 {
                    log.error("🚷 Authentication error on \(response.url?.path ?? "unknown"): \(networkFailureError)")
                    self.refreshToken { token in
                        log.info("New access token: \(token)")
                        self.performRequest(router: router, route: route, decoder: decoder, completion: completion)
                    }
                } else {
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    private func performRequest<T: Decodable>(router: Router<EndPoint>,
                                              route: EndPoint,
                                              decoder: JSONDecoder = JSONDecoder(),
                                              completion: @escaping (_ response: T?, _ hasMoreContentAvailable: Bool, _ error: String?) -> Void) {
        
        router.request(route) { data, response, error in
            
            if error != nil {
                completion(nil, false, "Please check your network connection.")
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            let result = self.handleNetworkResponse(response)
            
            switch result {
            case .success:
                guard let responseData = data else {
                    completion(nil, false, NetworkResponse.noData.rawValue)
                    return
                }
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    NetworkLogger.log(httpMethod: route.httpMethod, response: response, data: jsonData)
                    let data = try decoder.decode(T.self, from: responseData)
                    // If the status code is 206, this means that we have a paginated list and more content is available
                    completion(data, response.statusCode == 206, nil)
                } catch {
                    log.error(error)
                    completion(nil, false, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                if response.statusCode == 401 {
                    log.error("🚷 Authentication error on \(response.url?.path ?? "unknown"): \(networkFailureError)")
                    self.refreshToken { token in
                        log.info("New access token: \(token)")
                        self.performRequest(router: router, route: route, decoder: decoder, completion: completion)
                    }
                } else {
                    completion(nil, false, networkFailureError)
                }
            }
        }
    }
    
    private func performRequest(router: Router<EndPoint>,
                                route: EndPoint,
                                decoder: JSONDecoder = JSONDecoder(),
                                completion: @escaping (_ error: String?) -> Void) {
        
        router.request(route) { data, response, error in
            
            if error != nil {
                completion("Please check your network connection.")
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            switch self.handleNetworkResponse(response) {
            case .success:
                NetworkLogger.log(httpMethod: route.httpMethod, response: response)
                completion(data != nil ? nil : NetworkResponse.noData.rawValue)
                
            case .failure(let networkFailureError):
                if response.statusCode == 401 {
                    log.error("🚷 Authentication error on \(response.url?.path ?? "unknown"): \(networkFailureError)")
                    self.refreshToken { token in
                        log.info("New access token: \(token)")
                        self.performRequest(router: router, route: route, decoder: decoder, completion: completion)
                    }
                } else {
                    completion(networkFailureError)
                }
            }
        }
        
    }
    
    private func performRequest(router: Router<EndPoint>,
                                route: EndPoint,
                                jsonKey: String,
                                decoder: JSONDecoder = JSONDecoder(),
                                completion: @escaping (_ response: String?, _ error: String?) -> Void) {
        
        router.request(route) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            let result = self.handleNetworkResponse(response)
            
            switch result {
            case .success:
                guard let responseData = data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    NetworkLogger.log(httpMethod: route.httpMethod, response: response, data: jsonData)
                    
                    // TODO: This should be [String: Any] and casted after but issue with completion handler
                    guard let data = jsonData as? [String: Int] else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    let message: String = "\(data[jsonKey] ?? 0)"
                    completion(message, nil)
                } catch {
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                if response.statusCode == 401 {
                    log.error("🚷 Authentication error on \(response.url?.path ?? "unknown"): \(networkFailureError)")
                    self.refreshToken { token in
                        log.info("New access token: \(token)")
                        self.performRequest(router: router, route: route, jsonKey: jsonKey, decoder: decoder, completion: completion)
                    }
                } else {
                    completion(nil, networkFailureError)
                }
            }
        }
        
    }
    
    
    // MARK: - Helper methods
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure("Error \(response.statusCode) - \(NetworkResponse.authenticationError.rawValue) ")
        case 501...599: return .failure("Error \(response.statusCode) - \(NetworkResponse.badRequest.rawValue)")
        case 600: return .failure("Error \(response.statusCode) - \(NetworkResponse.outdated.rawValue)")
        default: return .failure("Error \(response.statusCode) - \(NetworkResponse.failed.rawValue)")
        }
    }
    
    private func refreshToken(completionHandler: @escaping (String) -> Void) {
        log.verbose("♻️ Renewing access token and retrying request")
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { token, error in
            if let error = error {
                log.error("🚷 Error refreshing the access token \(error.localizedDescription)")
            }
            if let token = token {
                SharedKeychain.instance.accessToken = token
                completionHandler(token)
            }
        }
    }
    
}

// MARK: - Network Response

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

// MARK: - Result

enum Result<String> {
    case success
    case failure(String)
}
