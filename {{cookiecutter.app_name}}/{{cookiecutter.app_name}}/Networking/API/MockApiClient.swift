//
//  MockApiClient.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

final class MockedApiClient: Api {
    
    func fetchMovies(completion: @escaping ([Movie]?) -> Void) {
        if let path = Bundle.main.path(forResource: "mocked-data", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let temp_data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let movies = try? JSONDecoder().decode([Movie].self, from: temp_data)
                completion(movies)
            } catch _ as NSError {
                fatalError("Couldn't load data from \(path)")
            }
        }
    }
    
}
