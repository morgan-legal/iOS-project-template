//
//  MockApiClient.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

final class MockedApiClient: Api {
    
    private(set) var router = Router<EndPoint>(isMocked: true)
    
}
