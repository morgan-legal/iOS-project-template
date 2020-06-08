//
//  AppDelegate.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit
import SwiftyBeaver

/* The application logger */
let log = SwiftyBeaver.self

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy private var router = RootRouter()
    lazy private var deeplinkHandler = DeeplinkHandler()
    lazy private var notificationsHandler = NotificationsHandler()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // add log destinations. at least one is needed!
        let console = ConsoleDestination()  // log to Xcode Console
        let file = FileDestination()  // log to default swiftybeaver.log file

        // add the destinations to SwiftyBeaver
        log.addDestination(console)
        log.addDestination(file)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        // Notifications
        notificationsHandler.configure()

        // App structure
        router.loadMainAppStructure()

        return true
    }

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // To enable full universal link functionality add and configure the associated domain capability
        // https://developer.apple.com/library/content/documentation/General/Conceptual/AppSearch/UniversalLinks.html
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL {
            deeplinkHandler.handleDeeplink(with: url)
        }
        return true
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // To enable full remote notifications functionality you should first register the device with your api service
        //https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/
        notificationsHandler.handleRemoteNotification(with: userInfo)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // Handle deeplink
        return false
    }
    
}
