//
//  UIView+Extensions.swift
//  Stylee
//
//  Created by Morgan Le Gal on 09/06/2020.
//  Copyright © 2020 MadSeven. All rights reserved.
//

import UIKit

// MARK: Adding/Removing Shadows

extension UIView {
    
    func addShadow(
        color: UIColor? = R.color.shadow(),
        radius: CGFloat,
        opacity: Float,
        offset: CGSize? = .zero,
        viewBounds: CGRect = .zero,
        cornerRadius: CGFloat? = nil,
        shouldFollowPath: Bool = false
    ) {

        layer.shadowColor = (color ?? R.color.shadow() ?? .lightGray).cgColor
        layer.shadowOffset = offset ?? .zero
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        // Caching shadow (avoiding it to be redrawn)
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        if !shouldFollowPath {
            return
        }
        
        // Setting the shadowPath will improve the performances 
        if let cornerRadius = cornerRadius {
            layer.shadowPath = UIBezierPath(roundedRect: viewBounds, cornerRadius: cornerRadius).cgPath
        } else {
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
        
    }
    
    func addPathShadow(
        radius: CGFloat,
        opacity: Float
    ) {
        // Forces the frame to be calculated
        layoutIfNeeded()
        
        addShadow(
            radius: radius,
            opacity: opacity,
            viewBounds: bounds,
            cornerRadius: nil,
            shouldFollowPath: true
        )
    }
    
    func addRoundShadow(
        radius: CGFloat,
        opacity: Float
    ) {
        // Forces the frame to be calculated
        layoutIfNeeded()
        
        addShadow(
            radius: radius,
            opacity: opacity,
            viewBounds: bounds,
            cornerRadius: bounds.height / 2,
            shouldFollowPath: true
        )
    }
    
    func addCorneredShadow(
        radius: CGFloat,
        opacity: Float,
        cornerRadius: CGFloat
    ) {
        // Forces the frame to be calculated
        layoutIfNeeded()
        
        addShadow(
            radius: radius,
            opacity: opacity,
            viewBounds: bounds,
            cornerRadius: cornerRadius,
            shouldFollowPath: true
        )
    }
    
    func removeShadow() {
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 0
        layer.shadowRadius = 0
    }
    
}

// MARK: UIView + Keyboard

extension UIView {
    
    ///  Tells how much of the height of the receiving view is covered by the keyboard
    ///  Nice extension to be used, particularly on iPad with orientation and the varios view
    ///  controller presentation styles
    ///  But can nonetheless by used on iPhone too
    ///
    ///  - parameter keyboardSize: the size of the keyboard displayed on screen
    ///
    ///  - returns: the height of the view covered by the keyboard
    func heightCoveredByKeyboardOfSize(_ keyboardSize: CGSize) -> CGFloat {
        let frameInWindow = convert(bounds, to: nil)
        guard let windowBounds = window?.bounds else { return 0 }
        
        let keyboardTop = windowBounds.size.height - keyboardSize.height
        let viewBottom = frameInWindow.origin.y + frameInWindow.size.height
        
        return max(0, viewBottom - keyboardTop)
    }
    
}
