//
//  LayoutExtensionsTests.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import XCTest

@testable import {{cookiecutter.app_name}}

class LayoutExtensionsTests: XCTestCase {
    
    // MARK: - Properties
    
    var view: UIView!
    var label: UILabel!
    
    // MARK: - Setup
    
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
    
    func testAddSubviewConstraintsActivated() {
        let constraint = view.leadingAnchor |=| label.leadingAnchor
        view.addSubview(label, constraints: [
            constraint
        ])
        
        XCTAssertFalse(label.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(view.subviews.contains(label))
        
        XCTAssertEqual(constraint.isActive, true)
    }
    
    func testAddSbuviewConstraintsDeactivated() {
        let constraint = view.leadingAnchor |=| label.leadingAnchor
        view.addSubview(label, constraints: [
            constraint
        ], shouldActivateConstraints: false)
        
        XCTAssertFalse(label.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(view.subviews.contains(label))
        
        XCTAssertEqual(constraint.isActive, false)
    }
    
    func testCustomAnchors() {
        let horizontalAnchors = view.horizontalAnchors
        XCTAssertEqual(horizontalAnchors.first, view.leadingAnchor)
        XCTAssertEqual(horizontalAnchors.second, view.trailingAnchor)
        
        let verticalAnchors = view.verticalAnchors
        XCTAssertEqual(verticalAnchors.first, view.topAnchor)
        XCTAssertEqual(verticalAnchors.second, view.bottomAnchor)
        
        let centerAnchors = view.centerAnchors
        XCTAssertEqual(centerAnchors.first, view.centerXAnchor)
        XCTAssertEqual(centerAnchors.second, view.centerYAnchor)
        
        let sizeAnchors = view.sizeAnchors
        XCTAssertEqual(sizeAnchors.first, view.widthAnchor)
        XCTAssertEqual(sizeAnchors.second, view.heightAnchor)
        
        let edgeAnchors = view.edgeAnchors
        XCTAssertEqual(edgeAnchors.first.first, view.horizontalAnchors.first)
        XCTAssertEqual(edgeAnchors.first.second, view.horizontalAnchors.second)
        XCTAssertEqual(edgeAnchors.second.first, view.verticalAnchors.first)
        XCTAssertEqual(edgeAnchors.second.second, view.verticalAnchors.second)
    }
    
    func testActivateConstraints() {
        view.addSubview(label)
        
        // Activate single constraint
        
        let singleConstraint = view.leadingAnchor |=| label.leadingAnchor
        XCTAssertFalse(singleConstraint.isActive)
        
        singleConstraint.activate()
        
        XCTAssertTrue(singleConstraint.isActive)
        
        // Activate multiple constraints
        
        let multipleConstraints = view.verticalAnchors |=| label.verticalAnchors
        
        multipleConstraints.forEach {
            XCTAssertFalse($0.isActive)
        }
        
        multipleConstraints.activate()
        
        multipleConstraints.forEach {
            XCTAssertTrue($0.isActive)
        }
    }
    
    func testDeactivateConstraints() {
        view.addSubview(label)
        
        // Deactivate single constraint

        let singleConstraint = view.leadingAnchor |=| label.leadingAnchor
        singleConstraint.isActive = true
        
        singleConstraint.deactivate()
        
        XCTAssertFalse(singleConstraint.isActive)
        
        // Deactivate multiple constraints
        
        let multipleConstraints = view.verticalAnchors |=| label.verticalAnchors
        multipleConstraints.forEach { $0.isActive = true }
        
        multipleConstraints.deactivate()
        
        multipleConstraints.forEach {
            XCTAssertFalse($0.isActive)
        }
    }
    
    func testMultiplierConstraint() {
        let constraint = (view.centerXAnchor |=| label.centerXAnchor)
            .multiplied(by: 2.0)
        
        XCTAssertEqual(constraint.multiplier, 2.0)
    }
}
