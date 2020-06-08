//
//  Api.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

protocol Api {
    func fetchMovies(completion: @escaping ([Movie]?) -> Void)
}
