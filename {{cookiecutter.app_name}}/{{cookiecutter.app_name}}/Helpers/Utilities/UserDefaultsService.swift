//
//  UserDefaultsService.swift
//  {{cookiecutter.app_name}}
//
//  Created by Morgan Le Gal on 1/24/21.
//  Copyright © 2021 {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

// Inspired by: https://swiftsenpai.com/swift/create-the-perfect-userdefaults-wrapper-using-property-wrapper/
// Note: do not use the Codable version of this tutorial, it doesn't work

// MARK: - Descriptor

protocol UserDefaultsServiceDescriptor: Service {
  
    // Example of variable stored in UserDefaults
    var appOpenedCounter: Int { get set }
    
    // Methods
    func removeObject(key: UserDefaultsKeys)
}

enum UserDefaultsKeys: String {
    case appOpenedCounter
}

// MARK: - Service

class UserDefaultsService: UserDefaultsServiceDescriptor {
    
    // MARK: Singleton
    
    static let instance = UserDefaultsService()
    
    // MARK: Exposed stored properties
    
    @UserDefaultsStorage(key: UserDefaultsKeys.appOpenedCounter.rawValue, defaultValue: 0)
    var appOpenedCounter: Int
    
    // Do not set the optional value to nil but remove it this way
    func removeObject(key: UserDefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
}

// MARK: - Property Wrapper

@propertyWrapper
struct UserDefaultsStorage<T> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
}
