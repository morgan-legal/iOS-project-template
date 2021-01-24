//
//  UIViewController+Extensions.swift
//  Stylee
//
//  Created by Morgan Le Gal on 05/06/2020.
//  Copyright © 2020 MadSeven. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}

extension UIViewController {
    
    /// This property will find the last presented view controller in the stack.
    /// Recursively looping through presented controllers to find the top one.
    var lastPresentedViewController: UIViewController {
        if let presentedViewController = presentedViewController {
            return presentedViewController.lastPresentedViewController
        } else {
            return self
        }
    }
    
}
