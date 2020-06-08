//
//  AppServices.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

final class AppService: NSObject {
    
    /// The singleton instance
    static let instance = AppServices()
    
    
    // MARK: Services
    
    private(set) var api: Api
    
    private(set) var movieService: MovieServiceDescriptor
    
    // MARK: Initializer
    
    override init() {
        /* To pass an argument go to: "Edit Scheme"  > "Run" > Tab "Arguments"
         Add a new argument in "Arguments passed on launch" */
        if CommandLine.arguments.contains("-mockedApi") {
            api = MockedApiClient()
        } else {
            api = ApiClient()
        }
        
        movieService = MovieService(api: api)
        
        super.init()
    }
    
}
