//
//  BaseCoordinator.swift
//  {{cookiecutter.app_name}}
//
//  Created by Morgan Le Gal on 1/24/21.
//  Copyright © 2021 {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

class BaseCoordinator: NSObject, CoordinatorDescriptor {
    
    // MARK: Exposed
    
    var currentViewController: UIViewController? {
        didSet {
            if let lastPresentingController = presentingControllers.last,
                lastPresentingController == currentViewController {
                return
            }
            
            if let presentingController = oldValue {
                presentingControllers.append(presentingController)
            }
        }
    }
    
    var presentingControllers: [UIViewController] = []
    
    // MARK: Lazy vars
    
    lazy var closeButton: UIBarButtonItem = {
        let b = UIBarButtonItem(image: R.image.navClose(), style: .done, target: self, action: #selector(closeButtonTapped))
        b.tintColor = R.color.primaryTextColor()
        return b
    }()
    
    // MARK: Exposed methods
    
    @objc
    private func closeButtonTapped() {
        dismissPresentingController()
    }
    
    func dismissPresentingController(completion: (() -> Void)? = nil) {
        currentViewController?.dismiss(animated: true) { [weak self] in
            self?.currentViewController = self?.presentingControllers.last
            self?.presentingControllers.removeLast()
            completion?()
        }
    }
    
    func doShowWebview(from controller: UIViewController? = nil, with url: URL?, title: String?) {
        let webViewController = WebViewController()
        let navController = CustomNavigationController(rootViewController: webViewController)
        webViewController.navigationItem.leftBarButtonItem = closeButton
        webViewController.title = title
        webViewController.navigationItem.largeTitleDisplayMode = .never
        webViewController.url = url
        navController.isToolbarHidden = false
        navController.navigationBar.isTranslucent = false
        if let controller = controller {
            navController.modalPresentationStyle = .overFullScreen
            controller.present(navController, animated: true, completion: nil)
        } else {
            present(viewController: navController)
        }
        currentViewController = navController
    }
    
    func openUrl(_ url: URL?) {
        guard let url = url,
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
}
