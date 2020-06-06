//
//  AppServices.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

final class AppService: NSObject {
    
    private(set) var api: Api = {
        /**
            To pass an argument go to:
            "Edit Scheme"
            > "Run"
            > Tab "Arguments"
            Add a new argument in "Arguments passed on launch"
         */
        if CommandLine.arguments.contains("-mockedApi") {
            return MockedApiClient()
        } else {
            return ApiClient()
        }
    }()
    
    override init() {
        super.init()
    }
    
}
