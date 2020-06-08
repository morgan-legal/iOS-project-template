//
//  FilmServiceDescriptor.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

// MARK: - MovieService descriptor

protocol MovieServiceDescriptor: Service {
    
    var movies: [Movie]? { get }
    
    /// Register a new delegate for the service
    ///
    /// - Parameter delegate: the delegate
    func register(delegate: MovieServiceDelegate)
    
    /// Unregister a delegate from the service
    ///
    /// - Parameter delegate: the delegate
    func unregister(delegate: MovieServiceDelegate)
}


// MARK: - MovieService delegate

/// A delegate for the post services
///
/// __Methods__:
/// - moviesUpdated _is triggered when one or several movies are added, updated or removed_
protocol MovieServiceDelegate: Delegate {

    func moviesUpdated()
    
}
