//
//  LayoutExtensions.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

// MARK: - UIView

extension UIView {
    /// Adds a view to the end of the receiver’s list of subviews by applying a given set of constraints.
    ///
    /// By default, this method sets the view's `translatesAutoresizingMaskIntoConstraints` to `false`
    /// and applies the set of constraints passed with the constraints. If the `activateConstraints`
    /// parameter is set to `true`, this method will also activate the layout constraints; otherwise
    /// the constraints are left as are.
    ///
    /// - Parameters:
    ///   - view: The view to be added. After being added, this view appears on top of any other subviews.
    ///   - constraints: A list of constraints to apply to this view.
    ///   - activateConstraints: Whether to directly activate the constraints. Defaults to `true`.
    func addSubview(_ view: UIView, constraints: [NSLayoutConstraint], shouldActivateConstraints activateConstraints: Bool = true) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if activateConstraints {
            constraints.activate()
        }
    }
    
    /// Adds a view to the end of the receiver’s list of subviews by applying a given set of constraints.
    ///
    /// By default, this method sets the view's `translatesAutoresizingMaskIntoConstraints` to `false`
    /// and applies the set of constraints passed with the constraints. If the `activateConstraints`
    /// parameter is set to `true`, this method will also activate the layout constraints; otherwise
    /// the constraints are left as are.
    ///
    /// - Parameters:
    ///   - view: The view to be added. After being added, this view appears on top of any other subviews.
    ///   - constraints: A list of constraints to apply to this view.
    ///   - activateConstraints: Whether to directly activate the constraints. Defaults to `true`.
    func addSubview(_ view: UIView, constraints: [[NSLayoutConstraint]], shouldActivateConstraints activateConstraints: Bool = true) {
        addSubview(view, constraints: constraints.reduce([], +))
    }
    
    func addLayoutGuide(_ guide: UILayoutGuide, constraints: [NSLayoutConstraint], shouldActivateConstraints activateConstraints: Bool = true) {
        addLayoutGuide(guide)
        
        if activateConstraints {
            constraints.activate()
        }
    }
    
    /// An `AnchorPair` build with a view's leading and trailing anchors.
    var horizontalAnchors: HorizontalAnchors {
        return AnchorPair(first: leadingAnchor, second: trailingAnchor)
    }
    
    /// An `AnchorPair` build with a view's top and bottom anchors.
    var verticalAnchors: VerticalAnchors {
        return AnchorPair(first: topAnchor, second: bottomAnchor)
    }
    
    /// An `AnchorPair` build with a view's center X and center Y anchors.
    var centerAnchors: CenterAnchors {
        return AnchorPair(first: centerXAnchor, second: centerYAnchor)
    }

    /// An `AnchorPair` build with a view's width and height anchors.
    var sizeAnchors: SizeAnchors {
        return AnchorPair(first: widthAnchor, second: heightAnchor)
    }
    
    /// An `AnchorPair` build with a view's horizontal and vertical anchors.
    var edgeAnchors: EdgeAnchors {
        return AnchorPair(first: horizontalAnchors, second: verticalAnchors)
    }
    
}

// MARK: Layout Guide

extension UILayoutGuide {
    
    /// An `AnchorPair` build with a view's leading and trailing anchors.
    var horizontalAnchors: HorizontalAnchors {
        return AnchorPair(first: leadingAnchor, second: trailingAnchor)
    }
    
    /// An `AnchorPair` build with a view's top and bottom anchors.
    var verticalAnchors: VerticalAnchors {
        return AnchorPair(first: topAnchor, second: bottomAnchor)
    }
    
    /// An `AnchorPair` build with a view's center X and center Y anchors.
    var centerAnchors: CenterAnchors {
        return AnchorPair(first: centerXAnchor, second: centerYAnchor)
    }
    
    /// An `AnchorPair` build with a view's width and height anchors.
    var sizeAnchors: SizeAnchors {
        return AnchorPair(first: widthAnchor, second: heightAnchor)
    }
    
    /// An `AnchorPair` build with a view's horizontal and vertical anchors.
    var edgeAnchors: EdgeAnchors {
        return AnchorPair(first: horizontalAnchors, second: verticalAnchors)
    }
    
}

// MARK: - Array

extension Array where Element == NSLayoutConstraint {
    /// Activates each constraint in the specified array.
    func activate() {
        NSLayoutConstraint.activate(self)
    }
    
    /// Deactivates each constraint in the specified array.
    func deactivate() {
        NSLayoutConstraint.deactivate(self)
    }
}

// MARK: - NSLayoutConstraint

extension NSLayoutConstraint {
    /// Activates the layout constraint.
    ///
    /// This is the same as setting the `isActive` property to `true`.
    ///
    /// - Returns: The layout constraint.
    @discardableResult func activate() -> NSLayoutConstraint {
        self.isActive = true
        return self
    }
    
    /// Deactivates the layout constraint.
    ///
    /// This is the same as setting the `isActive` property to `false`.
    ///
    /// - Returns: The layout constraint.
    @discardableResult func deactivate() -> NSLayoutConstraint {
        self.isActive = false
        return self
    }
    
    func multiplied(by multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: firstItem!,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant
        )
    }
}
