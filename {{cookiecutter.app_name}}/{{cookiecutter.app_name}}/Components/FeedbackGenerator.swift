//
//  FeedbackGenerator.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

/**
 A helper class that make it easier to send taptic feedbacks
 (in the form of notification feedbacks).
 
 It's abstracting the preparation and release of the generator with a static implementation.
 But you can also instantiate it and still benefit from automatic release while having
 the ability to prepare the generator.
 */
final class NotificationFeedbackGenerator {
    
    // MARK: - Private Properties
    
    /** A feedback generator used to spray sparkles to the hand of the user!
     This is the "hidden" version. This manipulation was needed in order to safely
     access the generator while allowing it to become nil. */
    private lazy var _notificationGenerator: UINotificationFeedbackGenerator! = UINotificationFeedbackGenerator()
    
    /// A feedback generator used to spray sparkles to the hand of the user!
    private var notificationGenerator: UINotificationFeedbackGenerator! {
        get {
            if _notificationGenerator == nil {
                _notificationGenerator = UINotificationFeedbackGenerator()
            }
            
            return _notificationGenerator
        }
        set {
            _notificationGenerator = newValue
        }
    }
    
}

extension NotificationFeedbackGenerator {
    
    // MARK: - Public Methods
    
    /// Prepare the feedback generator in order to minimize its latency. This is totally optional
    func prepare() {
        notificationGenerator.prepare()
    }
    
    /// Perform a taptic feedback with this generator.
    ///
    /// - Parameters:
    ///   - notificationType: The kind of notification feedback you want the generator to execute.
    ///   - shouldRelease: A boolean value (that is true by default) to release the generator after the feedback was performed.
    func perform(_ notificationType: UINotificationFeedbackGenerator.FeedbackType, shouldRelease: Bool = true) {
        notificationGenerator.notificationOccurred(notificationType)
        
        if shouldRelease {
            release()
        }
    }
    
    /// Perform a notification taptic feedback without caring about the generator.
    ///
    /// - Parameter notificationType: The kind of notification feedback you want the generator to execute.
    static func perform(_ notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        NotificationFeedbackGenerator().perform(notificationType)
    }
    
    /// Release the generator so the device's taptic engine is efficiently shut down.
    func release() {
        notificationGenerator = nil
    }
    
}

/**
 A helper class that make it easier to send taptic feedbacks
 (in the form of selection feedbacks).
 
 It's abstracting the preparation and release of the generator with a static implementation.
 But you can also instantiate it and still benefit from automatic release while having
 the ability to prepare the generator.
 */
final class SelectionFeedbackGenerator {
    
    // MARK: - Private Properties
    
    /** A feedback generator used to spray sparkles to the hand of the user!
     This is the "hidden" version. This manipulation was needed in order to safely
     access the generator while allowing it to become nil. */
    private lazy var _selectionGenerator: UISelectionFeedbackGenerator! = UISelectionFeedbackGenerator()
    
    /// A feedback generator used to spray sparkles to the hand of the user!
    private var selectionGenerator: UISelectionFeedbackGenerator! {
        get {
            if _selectionGenerator == nil {
                _selectionGenerator = UISelectionFeedbackGenerator()
            }
            
            return _selectionGenerator
        }
        set {
            _selectionGenerator = newValue
        }
    }
    
}

extension SelectionFeedbackGenerator {
    
    // MARK: - Public Methods
    
    /// Prepare the feedback generator in order to minimize its latency. This is totally optional
    func prepare() {
        selectionGenerator.prepare()
    }
    
    /// Perform a taptic feedback with this generator.
    ///
    /// - Parameters:
    ///   - shouldRelease: A boolean value (that is true by default) to release the generator after the feedback was performed.
    func perform(shouldRelease: Bool = true) {
        selectionGenerator.selectionChanged()
        
        if shouldRelease {
            release()
        }
    }
    
    /// Perform a selection taptic feedback without caring about the generator.
    static func perform() {
        SelectionFeedbackGenerator().perform()
    }
    
    /// Release the generator so the device's taptic engine is efficiently shut down.
    func release() {
        selectionGenerator = nil
    }
    
}

/**
 A helper class that make it easier to send taptic feedbacks
 (in the form of impact feedbacks).
 
 It's abstracting the preparation and release of the generator with a static implementation.
 But you can also instantiate it and still benefit from automatic release while having
 the ability to prepare the generator.
 */
final class ImpactFeedbackGenerator {
    
    // MARK: - Private Properties
    
    /** A feedback generator used to spray sparkles to the hand of the user!
     This is the "hidden" version. This manipulation was needed in order to safely
     access the generator while allowing it to become nil. */
    private lazy var _impactGenerator: UIImpactFeedbackGenerator! = UIImpactFeedbackGenerator()
    
    /// A feedback generator used to spray sparkles to the hand of the user!
    private var impactGenerator: UIImpactFeedbackGenerator! {
        get {
            if _impactGenerator == nil {
                _impactGenerator = UIImpactFeedbackGenerator()
            }
            
            return _impactGenerator
        }
        set {
            _impactGenerator = newValue
        }
    }
    
}

extension ImpactFeedbackGenerator {
    
    // MARK: - Public Methods
    
    /// Prepare the feedback generator in order to minimize its latency. This is totally optional
    ///
    /// - Parameters:
    ///   - impactStyle: The kind of impact feedback you want the generator to execute.
    func prepare(forImpactOfStyle impactStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        impactGenerator = UIImpactFeedbackGenerator(style: impactStyle)
        impactGenerator.prepare()
    }
    
    /// Perform a taptic feedback with this generator.
    ///
    /// - Parameters:
    ///   - shouldRelease: A boolean value (that is true by default) to release the generator after the feedback was performed.
    func perform(shouldRelease: Bool = true) {
        impactGenerator.impactOccurred()
        
        if shouldRelease {
            release()
        }
    }
    
    /// Perform a notification taptic feedback without caring about the generator.
    ///
    /// - Parameter impactStyle: The kind of impact feedback you want the generator to execute.
    static func perform(_ impactStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = ImpactFeedbackGenerator()
        generator.prepare(forImpactOfStyle: impactStyle)
        generator.perform()
    }
    
    /// Release the generator so the device's taptic engine is efficiently shut down.
    func release() {
        impactGenerator = nil
    }
    
}
