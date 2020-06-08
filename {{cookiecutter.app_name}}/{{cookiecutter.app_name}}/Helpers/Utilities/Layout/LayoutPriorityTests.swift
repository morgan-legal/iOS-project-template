//
//  LayoutPriorityTests.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import XCTest

@testable import {{cookiecutter.app_name}}

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
