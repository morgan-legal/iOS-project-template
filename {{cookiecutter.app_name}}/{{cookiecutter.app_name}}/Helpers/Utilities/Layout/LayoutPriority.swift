//
//  LayoutPriority.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

precedencegroup LayoutPriorityPrecedence {
    associativity: none
    lowerThan: ComparisonPrecedence
}

infix operator ~: LayoutPriorityPrecedence

/// Applies a layout priority to the given constraint.
///
/// - Parameters:
///   - lhs: The layout constraint to which to apply a priority.
///   - rhs: The layout priority to apply.
///
/// - Returns: The layout priority with the new priority.
func ~ (lhs: NSLayoutConstraint, rhs: UILayoutPriority) -> NSLayoutConstraint {
    lhs.priority = rhs
    return lhs
}
