//
//  LayoutPriorityTests.swift
//  {{cookiecutter.app_name}}
//
//  Created by Morgan Le Gal on 06/06/2020.
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
//

import XCTest

class LayoutPriorityTests: XCTestCase {
    
    // MARK: - Properties
    
    var view: UIView!
    var label: UILabel!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        view = UIView()
        label = UILabel()
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        label = nil
    }
    
    // MARK: - Tests
    
    func testPriorityOperator() {
        let highPriorityConstraint = view.leadingAnchor |=| label.leadingAnchor ~ .defaultHigh
        XCTAssertEqual(highPriorityConstraint.priority, .defaultHigh)
        
        let customPriorityConstraint = view.leadingAnchor |=| label.leadingAnchor ~ .init(500.0)
        XCTAssertEqual(customPriorityConstraint.priority, .init(500))
    }
}
