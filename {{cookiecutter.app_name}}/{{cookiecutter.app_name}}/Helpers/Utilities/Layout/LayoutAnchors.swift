//
//  LayoutAnchors.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

// MARK: - Anchor Pair

/// An `AnchorPair` combines two anchors into a pair, which can be seen as
/// a single anchor.
struct AnchorPair<A: LayoutAnchor, B: LayoutAnchor>: LayoutAnchor {
    
    /// The first anchor
    let first: A
    
    /// The second anchor.
    let second: B
}

// MARK: - Type aliases

/// An `AnchorPair` combining two `NSLayoutXAxisAnchor`s, typically a pair of
/// a leading and a trailing anchors.
typealias HorizontalAnchors = AnchorPair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor>

/// An `AnchorPair` combining two `NSLayoutYAxisAnchor`s, typically a pair of
/// a top and a bottom anchors.
typealias VerticalAnchors = AnchorPair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor>

/// An `AnchorPair` combining a `NSLayoutXAxisAnchor` and a `NSLayoutYAxisAnchor`,
/// typically a pair of a top and a bottom anchors.
typealias CenterAnchors = AnchorPair<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor>

/// An `AnchorPair` combining two `NSLayoutDimension`s, typically a pair of
/// width and a height anchors.
typealias SizeAnchors = AnchorPair<NSLayoutDimension, NSLayoutDimension>

/// An `AnchorPair` combining two `AnchorPairs`s, typically a pair of
/// horizontal and vertical anchors.
typealias EdgeAnchors = AnchorPair<HorizontalAnchors, VerticalAnchors>
