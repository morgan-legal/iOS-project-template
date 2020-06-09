//
//  FilmService.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

final class MovieService: NSObject, MovieServiceDescriptor {
    
    // MARK: Properties
    
    private(set) var movies: [Movie]?
    
    /// The API service
    private let api: Api
    
    /// The delegates for the service
    private var delegates: [MovieServiceDelegate] = []
    
    // MARK: Initializer
    
    init(api: Api) {
        self.api = api
        super.init()
    }
    
    deinit {
        delegates.removeAll()
    }

    // MARK: Exposed methods
    
    /// Register a new delegate for the service
    ///
    /// - Parameter delegate: the delegate
    func register(delegate: MovieServiceDelegate) {
        delegates.append(delegate)
    }
    
    /// Unregister a delegate from the service
    ///
    /// - Parameter delegate: the delegate
    func unregister(delegate: MovieServiceDelegate) {
        delegates = delegates.filter { $0 !== delegate }
    }
    
}
