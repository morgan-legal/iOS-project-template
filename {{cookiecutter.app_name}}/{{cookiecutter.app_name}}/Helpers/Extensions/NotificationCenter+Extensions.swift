//
//  NotificationCenter+Extensions.swift
//  Stylee
//
//  Created by Morgan Le Gal on 30/07/2020.
//  Copyright © 2020 MadSeven. All rights reserved.
//

import UIKit

/// # Description
///
///
/// A `NotificationDescriptor<A>` helps extracting relevant information from a notification. It is defined
/// by the combination of a `Notification.Name`, and a closure that transforms a `Notification` into the
/// associated piece of information (i.e. an `A`).
///
/// The `NotificationCenter` can then observe the `NotificationDescriptor<A>` and call a closure with the
/// extracted information. This has the benefit of having to write only once the logic related to extracting
/// the relative information from a notification.
///
/// Additionally, when observing a `NotificationDescriptor<A>` the `NotificationCenter` provides you with a
/// token. As long as you keep a reference to this token, the `NotificationCenter` keeps observing the
/// notification. Once the reference is lost, the observer is removed.
///
///
/// # How it works
///
///
/// 1. Create a model that represents the information you want to extract from the notification.
/// 2. Create the associated descriptor
/// 3. You're done...
///
/// You can than use the `NotificationCenter`'s `addObserver` method to start observing and reacting to your
/// notification.
///
///

// MARK: - Notification Descriptor

/// A description of a given notification.
struct NotificationDescriptor<A> {
    
    /// The name of the notification.
    let name: Notification.Name
    
    /// A method that converts a notification
    /// into the given payload.
    let convert: (Notification) -> A
    
}

// MARK: - Token

extension NotificationCenter {
    
    /// A `Token` manages the lifetime of a notification: when deinited, the
    /// observer is automatically removed from the notification center.
    class Token {
        
        /// An opaque object to act as the observer.
        let token: NSObjectProtocol
        
        /// The notification center to which the observer is added.
        let center: NotificationCenter
        
        /// Initialises a `Token`.
        ///
        /// - Parameters:
        ///   - token: An opaque object to act as the observer.
        ///   - center: The notification center to which the observer is added.
        init(token: NSObjectProtocol, center: NotificationCenter) {
            self.token = token
            self.center = center
        }
        
        deinit {
            center.removeObserver(token)
        }
        
    }
    
}

// MARK: - Notification Center

extension NotificationCenter {
    
    /// Adds an entry to the notification center's dispatch table.
    ///
    /// - Parameters:
    ///   - descriptor: The description of the notification to observe.
    ///   - block: The block to be executed when the notification is received.
    func addObserver<A>(descriptor: NotificationDescriptor<A>, using block: @escaping (A) -> Void) -> Token {
        let token = addObserver(forName: descriptor.name, object: nil, queue: nil) { notification in
            block(descriptor.convert(notification))
        }
        return Token(token: token, center: self)
    }
    
}

// MARK: - Common Notifications

struct KeyboardPayload {
    let animationCurve: UIView.AnimationCurve
    let animationDuration: Double
    let isLocal: Bool
    let frameBegin: CGRect
    let frameEnd: CGRect
    
    // swiftlint:disable force_cast
    // swiftlint:disable force_unwrapping
    fileprivate init(notification: Notification) {
        let userInfo = notification.userInfo!
        
        animationCurve = UIView.AnimationCurve(rawValue: userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
        animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        isLocal = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as! Bool
        frameBegin = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        frameEnd = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    }
    // swiftlint:enable force_unwrapping
    // swiftlint:enable force_cast
}

extension UIResponder {
    
    /// A notification descriptor for the `keyboardWillShowNotification`.
    static let keyboardWillShowDescriptor = NotificationDescriptor<KeyboardPayload>(
        name: UIResponder.keyboardWillShowNotification,
        convert: KeyboardPayload.init
    )
    
    /// A notification descriptor for the `keyboardWillHideNotification`.
    static let keyboardWillHideDescriptor = NotificationDescriptor<KeyboardPayload>(
        name: UIResponder.keyboardWillHideNotification,
        convert: KeyboardPayload.init
    )
    
}
