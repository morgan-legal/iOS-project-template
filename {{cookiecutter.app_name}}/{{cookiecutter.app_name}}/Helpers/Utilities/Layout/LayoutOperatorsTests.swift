//
//  LayoutOperatorsTests.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import XCTest

class LayoutOperatorsTests: XCTestCase {
    
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
    
    // MARK: - Equality Constraints
    
    func testDimensionEqualToValue() {
        let constraint = view.widthAnchor |=| 300.0
        
        XCTAssertEqual(constraint.constant, 300.0)
        XCTAssertEqual(constraint.relation, .equal)

        assertIdentical(constraint.firstItem, view)
        XCTAssertEqual(constraint.firstAttribute, .width)
        
        XCTAssertNil(constraint.secondItem)
    }
    
    func testDimensionEqualToAnotherDimension() {
        let constraint = view.widthAnchor |=| label.heightAnchor
        
        XCTAssertEqual(constraint.relation, .equal)

        assertIdentical(constraint.firstItem, view)
        XCTAssertEqual(constraint.firstAttribute, .width)
        
        assertIdentical(constraint.secondItem, label)
        XCTAssertEqual(constraint.secondAttribute, .height)
    }

    func testDimensionEqualToAnotherDimensionPlusConstant() {
        let constraint = view.heightAnchor |=| label.heightAnchor * 2.0
        
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual(constraint.multiplier, 2.0)

        assertIdentical(constraint.firstItem, view)
        XCTAssertEqual(constraint.firstAttribute, .height)
        
        assertIdentical(constraint.secondItem, label)
        XCTAssertEqual(constraint.secondAttribute, .height)
    }

    func testSizeAnchorsEqualToSize() {
        let constraints = view.sizeAnchors |=| CGSize(width: 200.0, height: 200.0)
        
        XCTAssertEqual(constraints.count, 2)
        
        XCTAssertEqual(constraints[0].relation, .equal)
        XCTAssertEqual(constraints[0].constant, 200.0)
        XCTAssertEqual(constraints[1].relation, .equal)
        XCTAssertEqual(constraints[1].constant, 200.0)

        assertIdentical(constraints[0].firstItem, view)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        
        assertIdentical(constraints[1].firstItem, view)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
    }
    
    func testSizeAnchorsEqualToAnotherSizeAnchor() {
        let constraints = view.sizeAnchors |=| label.sizeAnchors
        
        XCTAssertEqual(constraints.count, 2)
        
        XCTAssertEqual(constraints[0].relation, .equal)
        XCTAssertEqual(constraints[1].relation, .equal)
        
        assertIdentical(constraints[0].firstItem, view)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        assertIdentical(constraints[0].secondItem, label)
        XCTAssertEqual(constraints[0].secondAttribute, .width)
        
        assertIdentical(constraints[1].firstItem, view)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
        assertIdentical(constraints[1].secondItem, label)
        XCTAssertEqual(constraints[1].secondAttribute, .height)
    }
    
    func testSizeAnchorsEqualToAnotherSizeAnchorPlusSize() {
        let constraints = view.sizeAnchors |=| label.sizeAnchors + CGSize(width: 200.0, height: 100.0)

        XCTAssertEqual(constraints.count, 2)

        XCTAssertEqual(constraints[0].relation, .equal)
        XCTAssertEqual(constraints[0].constant, 200.0)
        XCTAssertEqual(constraints[1].relation, .equal)
        XCTAssertEqual(constraints[1].constant, 100.0)

        assertIdentical(constraints[0].firstItem, view)
        XCTAssertEqual(constraints[0].firstAttribute, .width)

        assertIdentical(constraints[0].secondItem, label)
        XCTAssertEqual(constraints[0].secondAttribute, .width)

        assertIdentical(constraints[1].firstItem, view)
        XCTAssertEqual(constraints[1].firstAttribute, .height)

        assertIdentical(constraints[1].secondItem, label)
        XCTAssertEqual(constraints[1].secondAttribute, .height)
    }
    
    func testEdgeAnchorsEqualToAnotherEdgeAnchor() {
        let constraints = view.edgeAnchors |=| label.edgeAnchors
        
        XCTAssertEqual(constraints.count, 4)
        
        XCTAssertEqual(constraints[0].relation, .equal)
        XCTAssertEqual(constraints[1].relation, .equal)
        XCTAssertEqual(constraints[2].relation, .equal)
        XCTAssertEqual(constraints[3].relation, .equal)

        assertIdentical(constraints[0].firstItem, view)
        XCTAssertEqual(constraints[0].firstAttribute, .leading)
        assertIdentical(constraints[0].secondItem, label)
        XCTAssertEqual(constraints[0].secondAttribute, .leading)
        
        assertIdentical(constraints[1].firstItem, view)
        XCTAssertEqual(constraints[1].firstAttribute, .trailing)
        assertIdentical(constraints[1].secondItem, label)
        XCTAssertEqual(constraints[1].secondAttribute, .trailing)
        
        assertIdentical(constraints[2].firstItem, view)
        XCTAssertEqual(constraints[2].firstAttribute, .top)
        assertIdentical(constraints[2].secondItem, label)
        XCTAssertEqual(constraints[2].secondAttribute, .top)
        
        assertIdentical(constraints[3].firstItem, view)
        XCTAssertEqual(constraints[3].firstAttribute, .bottom)
        assertIdentical(constraints[3].secondItem, label)
        XCTAssertEqual(constraints[3].secondAttribute, .bottom)
    }
    
    func testEdgeAnchorsEqualToAnotherEdgeAnchorPlusInsets() {
        let constraints = view.edgeAnchors |=| label.edgeAnchors + UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        XCTAssertEqual(constraints.count, 4)
        
        XCTAssertEqual(constraints[0].relation, .equal)
        XCTAssertEqual(constraints[0].constant, 10.0)
        XCTAssertEqual(constraints[1].relation, .equal)
        XCTAssertEqual(constraints[1].constant, -10.0)
        XCTAssertEqual(constraints[2].relation, .equal)
        XCTAssertEqual(constraints[2].constant, 10.0)
        XCTAssertEqual(constraints[3].relation, .equal)
        XCTAssertEqual(constraints[3].constant, -10.0)

        assertIdentical(constraints[0].firstItem, view)
        XCTAssertEqual(constraints[0].firstAttribute, .leading)
        assertIdentical(constraints[0].secondItem, label)
        XCTAssertEqual(constraints[0].secondAttribute, .leading)
        
        assertIdentical(constraints[1].firstItem, view)
        XCTAssertEqual(constraints[1].firstAttribute, .trailing)
        assertIdentical(constraints[1].secondItem, label)
        XCTAssertEqual(constraints[1].secondAttribute, .trailing)
        
        assertIdentical(constraints[2].firstItem, view)
        XCTAssertEqual(constraints[2].firstAttribute, .top)
        assertIdentical(constraints[2].secondItem, label)
        XCTAssertEqual(constraints[2].secondAttribute, .top)
        
        assertIdentical(constraints[3].firstItem, view)
        XCTAssertEqual(constraints[3].firstAttribute, .bottom)
        assertIdentical(constraints[3].secondItem, label)
        XCTAssertEqual(constraints[3].secondAttribute, .bottom)
    }
    
    // MARK: - Greater Than Or Equal To Constraints
    
    func testDimensionGreaterThanOrEqualToValue() {
        let constraint = view.widthAnchor |>=| 300.0
        
        XCTAssertEqual(constraint.constant, 300.0)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        
        assertIdentical(constraint.firstItem, view)
        XCTAssertEqual(constraint.firstAttribute, .width)
        
        XCTAssertNil(constraint.secondItem)
    }
    
    func testDimensionGreaterThanOrToAnotherDimension() {
        let constraint = view.widthAnchor |>=| label.heightAnchor
        
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        
        assertIdentical(constraint.firstItem, view)
        XCTAssertEqual(constraint.firstAttribute, .width)
        
        assertIdentical(constraint.secondItem, label)
        XCTAssertEqual(constraint.secondAttribute, .height)
    }
    
    func testDimensionGreaterThanOrToAnotherDimensionPlusConstant() {
        let constraint = view.heightAnchor |>=| label.heightAnchor * 2.0
        
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssertEqual(constraint.multiplier, 2.0)
        
        assertIdentical(constraint.firstItem, view)
        XCTAssertEqual(constraint.firstAttribute, .height)
        
        assertIdentical(constraint.secondItem, label)
        XCTAssertEqual(constraint.secondAttribute, .height)
    }
    
    func testSizeAnchorsGreaterThanOrEqualToSize() {
        let constraints = view.sizeAnchors |>=| CGSize(width: 200.0, height: 200.0)
        
        XCTAssertEqual(constraints.count, 2)
        
        XCTAssertEqual(constraints[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(constraints[0].constant, 200.0)
        XCTAssertEqual(constraints[1].relation, .greaterThanOrEqual)
        XCTAssertEqual(constraints[1].constant, 200.0)
        
        assertIdentical(constraints[0].firstItem, view)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        
        assertIdentical(constraints[1].firstItem, view)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
    }
    
    func testSizeAnchorsGreaterThanOrToAnotherSizeAnchor() {
        let constraints = view.sizeAnchors |>=| label.sizeAnchors
        
        XCTAssertEqual(constraints.count, 2)
        
        XCTAssertEqual(constraints[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(constraints[1].relation, .greaterThanOrEqual)
        
        assertIdentical(constraints[0].firstItem, view)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        assertIdentical(constraints[0].secondItem, label)
        XCTAssertEqual(constraints[0].secondAttribute, .width)
        
        assertIdentical(constraints[1].firstItem, view)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
        assertIdentical(constraints[1].secondItem, label)
        XCTAssertEqual(constraints[1].secondAttribute, .height)
    }
    
    func testSizeAnchorsGreaterThanOrToAnotherSizeAnchorPlusSize() {
        let constraints = view.sizeAnchors |>=| label.sizeAnchors + CGSize(width: 200.0, height: 100.0)
        
        XCTAssertEqual(constraints.count, 2)
        
        XCTAssertEqual(constraints[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(constraints[0].constant, 200.0)
        XCTAssertEqual(constraints[1].relation, .greaterThanOrEqual)
        XCTAssertEqual(constraints[1].constant, 100.0)
        
        assertIdentical(constraints[0].firstItem, view)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        
        assertIdentical(constraints[0].secondItem, label)
        XCTAssertEqual(constraints[0].secondAttribute, .width)
        
        assertIdentical(constraints[1].firstItem, view)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
        
        assertIdentical(constraints[1].secondItem, label)
        XCTAssertEqual(constraints[1].secondAttribute, .height)
    }
    
    // MARK: - Less Than Or Equal To Constraints
    
    func testDimensionLessThanOrEqualToValue() {
        let constraint = view.widthAnchor |<=| 300.0
        
        XCTAssertEqual(constraint.constant, 300.0)
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        
        assertIdentical(constraint.firstItem, view)
        XCTAssertEqual(constraint.firstAttribute, .width)
        
        XCTAssertNil(constraint.secondItem)
    }
    
    func testDimensionLessThanOrToAnotherDimension() {
        let constraint = view.widthAnchor |<=| label.heightAnchor
        
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        
        assertIdentical(constraint.firstItem, view)
        XCTAssertEqual(constraint.firstAttribute, .width)
        
        assertIdentical(constraint.secondItem, label)
        XCTAssertEqual(constraint.secondAttribute, .height)
    }
    
    func testDimensionLessThanOrToAnotherDimensionPlusConstant() {
        let constraint = view.heightAnchor |<=| label.heightAnchor / 2.0
        
        XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        XCTAssertEqual(constraint.multiplier, 1 / 2.0)
        
        assertIdentical(constraint.firstItem, view)
        XCTAssertEqual(constraint.firstAttribute, .height)
        
        assertIdentical(constraint.secondItem, label)
        XCTAssertEqual(constraint.secondAttribute, .height)
    }
    
    func testSizeAnchorsLessThanOrEqualToSize() {
        let constraints = view.sizeAnchors |<=| CGSize(width: 200.0, height: 200.0)
        
        XCTAssertEqual(constraints.count, 2)
        
        XCTAssertEqual(constraints[0].relation, .lessThanOrEqual)
        XCTAssertEqual(constraints[0].constant, 200.0)
        XCTAssertEqual(constraints[1].relation, .lessThanOrEqual)
        XCTAssertEqual(constraints[1].constant, 200.0)
        
        assertIdentical(constraints[0].firstItem, view)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        
        assertIdentical(constraints[1].firstItem, view)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
    }
    
    func testSizeAnchorsLessThanOrToAnotherSizeAnchor() {
        let constraints = view.sizeAnchors |<=| label.sizeAnchors
        
        XCTAssertEqual(constraints.count, 2)
        
        XCTAssertEqual(constraints[0].relation, .lessThanOrEqual)
        XCTAssertEqual(constraints[1].relation, .lessThanOrEqual)
        
        assertIdentical(constraints[0].firstItem, view)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        assertIdentical(constraints[0].secondItem, label)
        XCTAssertEqual(constraints[0].secondAttribute, .width)
        
        assertIdentical(constraints[1].firstItem, view)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
        assertIdentical(constraints[1].secondItem, label)
        XCTAssertEqual(constraints[1].secondAttribute, .height)
    }
    
    func testSizeAnchorsLessThanOrToAnotherSizeAnchorPlusSize() {
        let constraints = view.sizeAnchors |<=| label.sizeAnchors - CGSize(width: 200.0, height: 100.0)
        
        XCTAssertEqual(constraints.count, 2)
        
        XCTAssertEqual(constraints[0].relation, .lessThanOrEqual)
        XCTAssertEqual(constraints[0].constant, -200.0)
        XCTAssertEqual(constraints[1].relation, .lessThanOrEqual)
        XCTAssertEqual(constraints[1].constant, -100.0)
        
        assertIdentical(constraints[0].firstItem, view)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        
        assertIdentical(constraints[0].secondItem, label)
        XCTAssertEqual(constraints[0].secondAttribute, .width)
        
        assertIdentical(constraints[1].firstItem, view)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
        
        assertIdentical(constraints[1].secondItem, label)
        XCTAssertEqual(constraints[1].secondAttribute, .height)
    }

}

// MARK: - Helper

extension LayoutOperatorsTests {
    func assertIdentical(_ expression1: AnyObject?, _ expression2: AnyObject?, line: UInt = #line) {
        XCTAssertTrue(expression1 === expression2, line: line)
    }
}
