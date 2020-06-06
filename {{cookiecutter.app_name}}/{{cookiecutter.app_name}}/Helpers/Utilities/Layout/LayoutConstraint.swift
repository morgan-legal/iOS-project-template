//
//  LayoutConstraint.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

// MARK: - Layout Anchor

protocol LayoutAnchor {}
extension NSLayoutAnchor: LayoutAnchor {}

protocol LayoutConstant {}
extension CGFloat: LayoutConstant {}
extension UIEdgeInsets: LayoutConstant {}
extension CGSize: LayoutConstant {}

// MARK: - LayoutConstraint

/// A `LayoutConstraint` helps defining a constraint's properties,
/// such as its anchor, constant and multiplier.
struct LayoutConstraint<Anchor: LayoutAnchor, Constant: LayoutConstant> {
    
    /// The layout anchor to which the constraint is pinned, if any.
    let anchor: Anchor?
    
    /// The constant applied to the constraint.
    let constant: Constant
    
    /// The multiplier applied to the constraint.
    let multiplier: CGFloat
    
    /// Initialises a constraint.
    ///
    /// - Parameters:
    ///   - anchor: The layout anchor to which the constaint is pinned. Defaults to `nil`.
    ///   - constant: The constant applied to the constraint.
    ///   - multiplier: The multiplier applied to the constraint. Default to `1.0`.
    init(anchor: Anchor? = nil, constant: Constant, multiplier: CGFloat = 1.0) {
        self.anchor = anchor
        self.constant = constant
        self.multiplier = multiplier
    }
    
}
