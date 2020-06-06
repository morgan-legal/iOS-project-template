//
//  UIViewController+Extensions.swift
//  {{cookiecutter.app_name}}
//
//  Created by Morgan Le Gal on 06/06/2020.
//  Copyright © 2020 {{cookiecutter.company_name}}. All rights reserved.
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
