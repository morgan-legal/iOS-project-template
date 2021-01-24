//
//  CoordinatorDescriptor.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

protocol CoordinatorDescriptor {
    
    var currentViewController: UIViewController? { get }
    var presentingControllers: [UIViewController] { get }
    
    /// Method to present a view controller
    ///
    /// - Parameter viewController: the view controller to present
    func present(viewController: UIViewController, fromLastViewController: Bool, needNavigationContext needNavBar: Bool, forcePresent: Bool)
    
    /// Method to push a view controller
    /// Only works if currentController is a UINavigationController
    ///
    /// - Parameter viewController: the view controller to push
    func push(viewController: UIViewController)
}

/// Default implementation for CoordinatorDescriptors
extension CoordinatorDescriptor {
    
    func present(
        viewController: UIViewController,
        fromLastViewController: Bool = true,
        needNavigationContext needNavBar: Bool = true,
        forcePresent: Bool = false
    ) {
        
        let viewControllerToPresent: UIViewController
        
        // Create the navigation bar if needed
        if needNavBar && viewController as? UINavigationController == nil {
            viewControllerToPresent = UINavigationController(rootViewController: viewController)
        } else {
            viewControllerToPresent = viewController
        }
        
        // Apply the modal presentation style
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        
        let presentedViewController: UIViewController? = fromLastViewController
            ? currentViewController?.lastPresentedViewController
            : currentViewController
        
        presentedViewController?.present(viewControllerToPresent, animated: true)
    }
    
    func push(viewController: UIViewController) {
        if let navController = currentViewController as? UINavigationController {
            navController.pushViewController(viewController, animated: true)
        } else if let navController = currentViewController?.navigationController {
            navController.pushViewController(viewController, animated: true)
        } else if let splitController = currentViewController as? UISplitViewController {
            splitController.showDetailViewController(viewController, sender: self)
        }
    }
    
}
