//
//  LayoutOperators.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

// swiftlint:disable force_unwrapping

// MARK: - Equality Constraints

infix operator |=|: ComparisonPrecedence

// MARK: Layout Dimension

func |=| (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.constraint(equalToConstant: rhs)
}

func |=| (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: rhs)
}

func |=| (lhs: NSLayoutDimension, rhs: LayoutConstraint<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return lhs.constraint(equalTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant)
            .multiplied(by: rhs.multiplier)
    } else {
        return lhs.constraint(equalToConstant: rhs.constant)
    }
}

func |=| (lhs: SizeAnchors, rhs: CGSize) -> [NSLayoutConstraint] {
    return [
        lhs.first |=| rhs.width,
        lhs.second |=| rhs.height
    ]
}

func |=| (lhs: SizeAnchors, rhs: LayoutConstraint<SizeAnchors, CGFloat>) -> [NSLayoutConstraint] {
    if let anchor = rhs.anchor {
        return [
            lhs.first.constraint(equalTo: anchor.first, multiplier: rhs.multiplier, constant: rhs.constant),
            lhs.second.constraint(equalTo: anchor.second, multiplier: rhs.multiplier, constant: rhs.constant)
        ]
    } else {
        return [
            lhs.first.constraint(equalToConstant: rhs.constant),
            lhs.second.constraint(equalToConstant: rhs.constant)
        ]
    }
}

func |=| (lhs: SizeAnchors, rhs: SizeAnchors) -> [NSLayoutConstraint] {
    return [
        lhs.first |=| rhs.first,
        lhs.second |=| rhs.second
    ]
}

func |=| (lhs: SizeAnchors, rhs: LayoutConstraint<SizeAnchors, CGSize>) -> [NSLayoutConstraint] {
    return [
        lhs.first |=| rhs.anchor!.first + rhs.constant.width,
        lhs.second |=| rhs.anchor!.second + rhs.constant.height
    ]
}

// MARK: Horizontal Anchors

func |=| (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: rhs)
}

func |=| (lhs: NSLayoutXAxisAnchor, rhs: LayoutConstraint<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant)
}

func |=| (lhs: HorizontalAnchors, rhs: HorizontalAnchors) -> [NSLayoutConstraint] {
    return [
        lhs.first |=| rhs.first,
        lhs.second |=| rhs.second
    ]
}

func |=| (lhs: HorizontalAnchors, rhs: LayoutConstraint<HorizontalAnchors, UIEdgeInsets>) -> [NSLayoutConstraint] {
    return [
        lhs.first |=| rhs.anchor!.first + rhs.constant.left,
        lhs.second |=| rhs.anchor!.second - rhs.constant.right
    ]
}

// MARK: Vertical Anchors

func |=| (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: rhs)
}

func |=| (lhs: NSLayoutYAxisAnchor, rhs: LayoutConstraint<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: rhs.anchor!, constant: rhs.constant)
}

func |=| (lhs: VerticalAnchors, rhs: VerticalAnchors) -> [NSLayoutConstraint] {
    return [
        lhs.first |=| rhs.first,
        lhs.second |=| rhs.second
    ]
}

func |=| (lhs: VerticalAnchors, rhs: LayoutConstraint<VerticalAnchors, UIEdgeInsets>) -> [NSLayoutConstraint] {
    return [
        lhs.first |=| rhs.anchor!.first + rhs.constant.top,
        lhs.second |=| rhs.anchor!.second - rhs.constant.bottom
    ]
}

// MARK: Center Anchors

func |=| (lhs: CenterAnchors, rhs: CenterAnchors) -> [NSLayoutConstraint] {
    return [
        lhs.first |=| rhs.first,
        lhs.second |=| rhs.second
    ]
}

func |=| (lhs: CenterAnchors, rhs: LayoutConstraint<CenterAnchors, CGSize>) -> [NSLayoutConstraint] {
    return [
        lhs.first |=| rhs.anchor!.first + rhs.constant.width,
        lhs.second |=| rhs.anchor!.second + rhs.constant.height
    ]
}

// MARK: Edge Anchors

func |=| (lhs: EdgeAnchors, rhs: EdgeAnchors) -> [NSLayoutConstraint] {
    return (lhs.first |=| rhs.first)
        + (lhs.second |=| rhs.second)
}

func |=| (lhs: EdgeAnchors, rhs: LayoutConstraint<EdgeAnchors, UIEdgeInsets>) -> [NSLayoutConstraint] {
    return (lhs.first |=| rhs.anchor!.first + rhs.constant)
        + (lhs.second |=| rhs.anchor!.second + rhs.constant)
}

// MARK: - Less Than Or Equal To Constraints

infix operator |<=|: ComparisonPrecedence

// MARK: Layout Dimension

func |<=| (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualToConstant: rhs)
}

func |<=| (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualTo: rhs)
}

func |<=| (lhs: NSLayoutDimension, rhs: LayoutConstraint<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return lhs.constraint(lessThanOrEqualTo: anchor, constant: rhs.constant)
            .multiplied(by: rhs.multiplier)
    } else {
        return lhs.constraint(lessThanOrEqualToConstant: rhs.constant)
    }
}

func |<=| (lhs: SizeAnchors, rhs: CGSize) -> [NSLayoutConstraint] {
    return [
        lhs.first |<=| rhs.width,
        lhs.second |<=| rhs.height
    ]
}

func |<=| (lhs: SizeAnchors, rhs: SizeAnchors) -> [NSLayoutConstraint] {
    return [
        lhs.first |<=| rhs.first,
        lhs.second |<=| rhs.second
    ]
}

func |<=| (lhs: SizeAnchors, rhs: LayoutConstraint<SizeAnchors, CGSize>) -> [NSLayoutConstraint] {
    return [
        lhs.first |<=| rhs.anchor!.first + rhs.constant.width,
        lhs.second |<=| rhs.anchor!.second + rhs.constant.height
    ]
}

// MARK: Horizontal Anchors

func |<=| (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualTo: rhs)
}

func |<=| (lhs: NSLayoutXAxisAnchor, rhs: LayoutConstraint<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant)
}

func |<=| (lhs: HorizontalAnchors, rhs: HorizontalAnchors) -> [NSLayoutConstraint] {
    return [
        lhs.first |<=| rhs.first,
        rhs.second |<=| rhs.second
    ]
}

func |<=| (lhs: HorizontalAnchors, rhs: LayoutConstraint<HorizontalAnchors, UIEdgeInsets>) -> [NSLayoutConstraint] {
    return [
        lhs.first |<=| rhs.anchor!.first + rhs.constant.left,
        lhs.second |<=| rhs.anchor!.second - rhs.constant.right
    ]
}

// MARK: Vertical Anchors

func |<=| (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualTo: rhs)
}

func |<=| (lhs: NSLayoutYAxisAnchor, rhs: LayoutConstraint<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualTo: rhs.anchor!, constant: rhs.constant)
}

func |<=| (lhs: VerticalAnchors, rhs: VerticalAnchors) -> [NSLayoutConstraint] {
    return [
        lhs.first |<=| rhs.first,
        lhs.second |<=| rhs.second
    ]
}

func |<=| (lhs: VerticalAnchors, rhs: LayoutConstraint<VerticalAnchors, UIEdgeInsets>) -> [NSLayoutConstraint] {
    return [
        lhs.first |<=| rhs.anchor!.first + rhs.constant.top,
        lhs.second |<=| rhs.anchor!.second - rhs.constant.bottom
    ]
}

// MARK: - Greater Than Or Equal To Constraints

infix operator |>=|: ComparisonPrecedence

// MARK: Layout Dimension

func |>=| (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualToConstant: rhs)
}

func |>=| (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualTo: rhs)
}

func |>=| (lhs: NSLayoutDimension, rhs: LayoutConstraint<NSLayoutDimension, CGFloat>) -> NSLayoutConstraint {
    if let anchor = rhs.anchor {
        return lhs.constraint(greaterThanOrEqualTo: anchor, constant: rhs.constant)
            .multiplied(by: rhs.multiplier)
    } else {
        return lhs.constraint(greaterThanOrEqualToConstant: rhs.constant)
    }
}

func |>=| (lhs: SizeAnchors, rhs: CGSize) -> [NSLayoutConstraint] {
    return [
        lhs.first |>=| rhs.width,
        lhs.second |>=| rhs.height
    ]
}

func |>=| (lhs: SizeAnchors, rhs: SizeAnchors) -> [NSLayoutConstraint] {
    return [
        lhs.first |>=| rhs.first,
        lhs.second |>=| rhs.second
    ]
}

func |>=| (lhs: SizeAnchors, rhs: LayoutConstraint<SizeAnchors, CGSize>) -> [NSLayoutConstraint] {
    return [
        lhs.first |>=| rhs.anchor!.first + rhs.constant.width,
        lhs.second |>=| rhs.anchor!.second + rhs.constant.height
    ]
}

// MARK: Horizontal Anchors

func |>=| (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualTo: rhs)
}

func |>=| (lhs: NSLayoutXAxisAnchor, rhs: LayoutConstraint<NSLayoutXAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant)
}

func |>=| (lhs: HorizontalAnchors, rhs: HorizontalAnchors) -> [NSLayoutConstraint] {
    return [
        lhs.first |>=| rhs.first,
        rhs.second |>=| rhs.second
    ]
}

func |>=| (lhs: HorizontalAnchors, rhs: LayoutConstraint<HorizontalAnchors, UIEdgeInsets>) -> [NSLayoutConstraint] {
    return [
        lhs.first |>=| rhs.anchor!.first + rhs.constant.left,
        lhs.second |>=| rhs.anchor!.second - rhs.constant.right
    ]
}

// MARK: Vertical Anchors

func |>=| (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualTo: rhs)
}

func |>=| (lhs: NSLayoutYAxisAnchor, rhs: LayoutConstraint<NSLayoutYAxisAnchor, CGFloat>) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, constant: rhs.constant)
}

func |>=| (lhs: VerticalAnchors, rhs: VerticalAnchors) -> [NSLayoutConstraint] {
    return [
        lhs.first |>=| rhs.first,
        lhs.second |>=| rhs.second
    ]
}

func |>=| (lhs: VerticalAnchors, rhs: LayoutConstraint<VerticalAnchors, UIEdgeInsets>) -> [NSLayoutConstraint] {
    return [
        lhs.first |>=| rhs.anchor!.first + rhs.constant.top,
        lhs.second |>=| rhs.anchor!.second - rhs.constant.bottom
    ]
}

// MARK: - Algebra

// MARK: Layout Dimension

func + (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutConstraint<NSLayoutDimension, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: rhs)
}

func + (lhs: SizeAnchors, rhs: CGSize) -> LayoutConstraint<SizeAnchors, CGSize> {
    return LayoutConstraint(anchor: lhs, constant: rhs)
}

func + (lhs: EdgeAnchors, rhs: UIEdgeInsets) -> LayoutConstraint<EdgeAnchors, UIEdgeInsets> {
    return LayoutConstraint(anchor: lhs, constant: rhs)
}

func - (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutConstraint<NSLayoutDimension, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: -rhs)
}

func - (lhs: SizeAnchors, rhs: CGSize) -> LayoutConstraint<SizeAnchors, CGSize> {
    return LayoutConstraint(anchor: lhs, constant: CGSize(width: -rhs.width, height: -rhs.height))
}

func - (lhs: EdgeAnchors, rhs: UIEdgeInsets) -> LayoutConstraint<EdgeAnchors, UIEdgeInsets> {
    return LayoutConstraint(anchor: lhs, constant: UIEdgeInsets(top: -rhs.top, left: -rhs.left, bottom: -rhs.bottom, right: -rhs.right))
}

func * (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutConstraint<NSLayoutDimension, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: 0.0, multiplier: rhs)
}

func * (lhs: SizeAnchors, rhs: CGFloat) -> LayoutConstraint<SizeAnchors, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: 0.0, multiplier: rhs)
}

func / (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutConstraint<NSLayoutDimension, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: 0.0, multiplier: 1 / rhs)
}

// MARK: Layout Horizontal Axis

func + (lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> LayoutConstraint<NSLayoutXAxisAnchor, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: rhs)
}

func + (lhs: HorizontalAnchors, rhs: UIEdgeInsets) -> LayoutConstraint<HorizontalAnchors, UIEdgeInsets> {
    return LayoutConstraint(anchor: lhs, constant: rhs)
}

func - (lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> LayoutConstraint<NSLayoutXAxisAnchor, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: -rhs)
}

func - (lhs: HorizontalAnchors, rhs: UIEdgeInsets) -> LayoutConstraint<HorizontalAnchors, UIEdgeInsets> {
    return LayoutConstraint(anchor: lhs, constant: UIEdgeInsets(top: -rhs.top, left: -rhs.left, bottom: -rhs.bottom, right: -rhs.right))
}

func * (lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> LayoutConstraint<NSLayoutXAxisAnchor, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: 0.0, multiplier: rhs)
}

func / (lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> LayoutConstraint<NSLayoutXAxisAnchor, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: 0.0, multiplier: 1 / rhs)
}

// MARK: Layout Vertical Axis

func + (lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> LayoutConstraint<NSLayoutYAxisAnchor, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: rhs)
}

func + (lhs: VerticalAnchors, rhs: UIEdgeInsets) -> LayoutConstraint<VerticalAnchors, UIEdgeInsets> {
    return LayoutConstraint(anchor: lhs, constant: rhs)
}

func - (lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> LayoutConstraint<NSLayoutYAxisAnchor, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: -rhs)
}

func - (lhs: VerticalAnchors, rhs: UIEdgeInsets) -> LayoutConstraint<VerticalAnchors, UIEdgeInsets> {
    return LayoutConstraint(anchor: lhs, constant: UIEdgeInsets(top: -rhs.top, left: -rhs.left, bottom: -rhs.bottom, right: -rhs.right))
}

func * (lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> LayoutConstraint<NSLayoutYAxisAnchor, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: 0.0, multiplier: rhs)
}

func / (lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> LayoutConstraint<NSLayoutYAxisAnchor, CGFloat> {
    return LayoutConstraint(anchor: lhs, constant: 0.0, multiplier: 1 / rhs)
}
