//
//  SegmentedView.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

/**
 SegmentedView
 This class is our custom segmented control
 */
final class SegmentedView: UIView {
    
    // MARK: - Properties
    
    // MARK: Public
    
    /// A handler triggered when the user taps an unselected label
    var selectedIndexChanged: ((Int) -> Void)?
    
    /// The current selected index. Zero being the first index.
    private(set) var selectedIndex: Int = 0
    
    /// A boolean indicating wether or not the contentView is scrollable. The default value is false.
    var isScrollable: Bool = false {
        didSet {
            if isScrollable == oldValue {
                return
            }
            updateWidthConstraints()
        }
    }
    
    /// A boolean indicating wether or not the contentView has rounded corners. The default value is false.
    var hasRoundedCorners: Bool = true {
        didSet {
            if hasRoundedCorners == oldValue {
                return
            }
            updateCorners()
        }
    }
    
    /// The text font of the selected label
    var selectedTextFont: UIFont = FontBook.medium.of(size: 16) {
        didSet {
            if oldValue == selectedTextFont {
                return
            }
            updateLabelsStyling()
        }
    }
    
    /// The font color for the selected label
    /// Note: tab selected colors override this color (which is a default one)
    var selectedTextColor: UIColor = .red {
        didSet {
            if oldValue == selectedTextColor {
                return
            }
            updateLabelsStyling()
        }
    }
    
    /// The background color of the selected label
    var selectedBackgroundColor: UIColor = .white {
        didSet {
            if oldValue == selectedBackgroundColor {
                return
            }
            selectedBackgroundView.backgroundColor = selectedBackgroundColor
        }
    }
    
    /// The selected backgroundView's maximum height
    var selectedBackgroundViewHeight: CGFloat? {
        didSet {
            if oldValue == selectedBackgroundViewHeight {
                return
            }
            setNeedsUpdateConstraints()
        }
    }
    
    var selectionStyle: SelectionStyle = .rounded {
        didSet {
            if oldValue == selectionStyle {
                return
            }
            setNeedsUpdateConstraints()
        }
    }
    
    /// The text font of the unselected label
    var unselectedTextFont: UIFont = FontBook.regular.of(size: 15) {
        didSet {
            if oldValue == unselectedTextFont {
                return
            }
            updateLabelsStyling()
        }
    }
    
    /// The text color of the unselected label
    var unselectedTextColor: UIColor = .black {
        didSet {
            if oldValue == unselectedTextColor {
                return
            }
            updateLabelsStyling()
        }
    }
    
    /// The scrollView's content insets
    var scrollViewInsets: UIEdgeInsets = .zero {
        didSet {
            scrollView.contentInset = scrollViewInsets
        }
    }
    
    /// An array of tuples containing the text and textColor of each tab
    var tabs: [Tab] = [] {
        didSet {
            resetLabels()
            setNeedsUpdateConstraints()
        }
    }
    
    // MARK: Enumerations & Structs
    
    enum SelectionStyle {
        case rounded, underlined
    }
    
    /// A quick model object for symbolizing a SegmentedView's tab
    /// If no selectedBackgroundColor provided, tab will use the selectedBackgroundColors of the SegmentedView view
    struct Tab: Hashable {
        var text: String
        var selectedTextColor: UIColor?
        var accessibilityId: String?
        var selectedBackgroundColor: UIColor?
    }
    
    // MARK: Private
    
    /// The selected backgroundView's constraints, updated each time updateConstraints is triggered
    private var selectedBackgroundViewConstraints: [NSLayoutConstraint] = []
    
    /// An array of the labels widths constraints, updated each time we update isScrollable property
    private var labelsWidthConstraint: [NSLayoutConstraint] = []
    
    /// The contentView width constraints, updated each time we update isScrollable property
    private var contentViewWidthConstraint: NSLayoutConstraint?
    
    /// Array of each labels. One label per tab.
    private var labels: [UILabel] = []
    
    /// The scrollView, allowing a horizontal scroll when
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.clipsToBounds = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    /// The view inside the scrollView. It contains all the label and the selected background view.
    private lazy var contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    /// The selected background view
    private lazy var selectedBackgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = selectedBackgroundColor
        return v
    }()
    
    // MARK: Constants
    
    private struct Constants {
        
        /// Labels' insets
        static let labelsInsets: UIEdgeInsets = .init(top: 0, left: 15, bottom: 0, right: 15)
        
        /// Animation constants
        struct Animation {
            static let duration: TimeInterval = 0.6
            static let defaultSpringDamping: CGFloat = 1.0
            static let scrollableSpringDamping: CGFloat = 0.8
            static let initialSpringVelocity: CGFloat = 0.5
        }
    }
    
    // MARK: - View life cycle
    
    convenience init(tabs: [Tab]? = nil) {
        self.init(frame: .zero)
        
        self.tabs = tabs ?? []
        
        resetLabels()
        updateSelectedIndex(animated: false)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCorners()
    }
    
    override func updateConstraints() {
        let selectedLabel = labels[selectedIndex]
        
        NSLayoutConstraint.deactivate(selectedBackgroundViewConstraints)
        selectedBackgroundViewConstraints.removeAll()
        
        // The background is always bound to its label in terms of x-axis
        selectedBackgroundViewConstraints.append(selectedBackgroundView.leadingAnchor.constraint(equalTo: selectedLabel.leadingAnchor))
        selectedBackgroundViewConstraints.append(selectedBackgroundView.trailingAnchor.constraint(equalTo: selectedLabel.trailingAnchor))
        
        if selectionStyle == .rounded {
            // The background height depends on if it was fixed by the user (the dev)
            if let selectedBackgroundViewHeight = selectedBackgroundViewHeight {
                // Fixed height (but still bound to label top-bottom)
                selectedBackgroundViewConstraints.append(selectedBackgroundView.topAnchor.constraint(greaterThanOrEqualTo: selectedLabel.topAnchor))
                selectedBackgroundViewConstraints.append(selectedBackgroundView.bottomAnchor.constraint(lessThanOrEqualTo: selectedLabel.bottomAnchor))
                selectedBackgroundViewConstraints.append(selectedBackgroundView.centerYAnchor.constraint(equalTo: selectedLabel.centerYAnchor))
                selectedBackgroundViewConstraints.append(selectedBackgroundView.heightAnchor.constraint(equalToConstant: selectedBackgroundViewHeight))
            } else {
                // Label height
                selectedBackgroundViewConstraints.append(selectedBackgroundView.topAnchor.constraint(equalTo: selectedLabel.topAnchor))
                selectedBackgroundViewConstraints.append(selectedBackgroundView.bottomAnchor.constraint(equalTo: selectedLabel.bottomAnchor))
            }
        } else if selectionStyle == .underlined {
            selectedBackgroundViewConstraints.append(selectedBackgroundView.bottomAnchor.constraint(equalTo: selectedLabel.bottomAnchor))
            selectedBackgroundViewConstraints.append(selectedBackgroundView.heightAnchor.constraint(equalToConstant: selectedBackgroundViewHeight ?? 0))
        }
        
        NSLayoutConstraint.activate(selectedBackgroundViewConstraints)
        super.updateConstraints()
    }
    
    // MARK: - Public methods
    
    func setSelectedIndex(_ index: Int, animated: Bool = true) {
        let oldValue = selectedIndex
        selectedIndex = index
        
        if oldValue != selectedIndex {
            updateSelectedIndex(animated: animated)
        }
    }
    
    /// Public method used to retrieve the label frame at a specific index. Used for tooltips.
    func getTabView(at index: Int) -> UIView? {
        if index >= labels.count {
            // Out of bounds
            return nil
        }
        return labels[index]
    }
    
    // MARK: - Private methods
    
    // MARK: Setup
    
    /// Setup the class view
    private func setupView() {
        backgroundColor = .clear
        
        // Subviews
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(selectedBackgroundView)
        
        // Constraints
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    /// Recreates labels for the tabs
    private func resetLabels() {
        
        // Remove existing labels
        for label in self.labels {
            label.removeFromSuperview()
        }
        labels.removeAll(keepingCapacity: true)
        
        // Add new ones
        var lastLabel: UILabel?
        for index in 0..<tabs.count {
            
            // Creating new label, configuring it
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = tabs[index].text
            label.accessibilityIdentifier = tabs[index].accessibilityId
            label.textAlignment = .center
            label.accessibilityTraits = UIAccessibilityTraits.button
            label.isUserInteractionEnabled = true
            
            // Adding as subview of contentView
            contentView.addSubview(label)
            
            // Top and bottom constraints
            label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            if let lastLabel = lastLabel {
                // Leading constraint, if there was a label before
                label.leadingAnchor.constraint(equalTo: lastLabel.trailingAnchor).isActive = true
            } else {
                // Leading constraint, if this is the first label
                label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            }
            
            // Adding tap gesture
            let gesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
            label.addGestureRecognizer(gesture)
            
            // Adding to our array of labels
            labels.append(label)
            
            // And setting this label as the last one treated
            lastLabel = label
        }
        
        // Anchoring to contentview trailing
        if let lastLabel = lastLabel {
            lastLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        }
        
        // Update styling for labels
        updateLabelsStyling()
        
        // Labels constraints
        updateWidthConstraints()
        
        // Make sure the background view is still behind the labels
        contentView.sendSubviewToBack(selectedBackgroundView)
    }
    
    // MARK: Animations
    
    private func updateLabelsStyling() {
        // Update label fonts and colors
        
        // Unselecting
        for (index, label) in self.labels.enumerated() {
            if index != self.selectedIndex {
                // set all other labels to default font and color
                label.textColor = self.unselectedTextColor
                label.font = self.unselectedTextFont
            } else {
                if index >= 0, index < tabs.count, let tabSelectedColor = tabs[index].selectedTextColor {
                    // If the tab defined its own selected color, then use this one
                    label.textColor = tabSelectedColor
                } else {
                    // Otherwise use the one defined for the tab bar
                    label.textColor = self.selectedTextColor
                }
                label.font = self.selectedTextFont
            }
        }
        guard self.selectedIndex < self.tabs.count else {
            return
        }
        self.selectedBackgroundView.backgroundColor = self.tabs[self.selectedIndex].selectedBackgroundColor ?? self.selectedBackgroundColor
        
    }
    
    /// Display the selected tab with a sliding animation. The corners are set to be rounded.
    /// There's a possibility to round only selected corners but introducing a glitch in animation
    private func updateSelectedIndex(animated: Bool) {
        
        // If there are no labels, then we have nothing to do
        if labels.isEmpty {
            return
        }
        
        updateLabelsStyling()
        
        // Play a nice animation for moving the selected background view
        let springDamping: CGFloat = isScrollable ? Constants.Animation.scrollableSpringDamping : Constants.Animation.defaultSpringDamping
        
        if !animated {
            // Triggers the selectedBackgroundView constraints refresh
            self.setNeedsUpdateConstraints()
            // Query for a layout pass: needed to have correct frames for scroll to selected tab to work
            self.layoutIfNeeded()
        } else {
            SelectionFeedbackGenerator.perform()
            UIView.animate(withDuration: Constants.Animation.duration, delay: 0.0, usingSpringWithDamping: springDamping, initialSpringVelocity: Constants.Animation.initialSpringVelocity, options: [], animations: {
                // Triggers the selectedBackgroundView constraints refresh
                self.setNeedsUpdateConstraints()
                // Query for a layout pass: needed to animate the constraints update
                
                self.layoutIfNeeded()
                
            }, completion: nil)
        }
        
        /* Scrolls to the selected label (if not entirely visible) */
        let selectedLabel = labels[selectedIndex]
        self.scrollView.scrollRectToVisible(selectedLabel.frame, animated: animated)
        
        updateAccessibility()
    }
    
    private func updateCorners() {
        let cornerRadius: CGFloat = hasRoundedCorners ? bounds.height / 2 : 0
        
        layer.cornerRadius = cornerRadius
        contentView.layer.cornerRadius = cornerRadius
        
        if let selectedBackgroundViewHeight = selectedBackgroundViewHeight {
            selectedBackgroundView.layer.cornerRadius = selectedBackgroundViewHeight / 2
        } else {
            selectedBackgroundView.layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: Accessibility
    
    /// Updates accessibility traits to label
    private func updateAccessibility() {
        for (index, label) in labels.enumerated() {
            if index == selectedIndex {
                label.accessibilityTraits = [UIAccessibilityTraits.button, UIAccessibilityTraits.selected]
            } else {
                label.accessibilityTraits = UIAccessibilityTraits.button
            }
        }
    }
    
    // MARK: Constraints
    
    /**
     This method will handle width constraints on labels and the contentView (if not scrollable).
     To do so, we're looping through each labels and if the view is scrollable, the labels widths
     will be equal to their compressed size + padding. If the view is not scrollable, then it means
     that the contentView's width is equal to the scrollView's width (used for amount search).
     */
    private func updateWidthConstraints() {
        if let contentViewWidthConstraint = contentViewWidthConstraint {
            NSLayoutConstraint.deactivate([contentViewWidthConstraint])
        }
        
        NSLayoutConstraint.deactivate(labelsWidthConstraint)
        labelsWidthConstraint.removeAll()
        
        if isScrollable {
            contentViewWidthConstraint = nil
        } else {
            contentViewWidthConstraint = contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        }
        
        labels.forEach { label in
            if isScrollable {
                labelsWidthConstraint.append(label.widthAnchor.constraint(equalToConstant: label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width + Constants.labelsInsets.left + Constants.labelsInsets.right))
            } else {
                labelsWidthConstraint.append(label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1 / CGFloat(labels.count)))
            }
        }
        
        contentViewWidthConstraint?.isActive = true
        NSLayoutConstraint.activate(labelsWidthConstraint)
    }
    
    // MARK: - User Interactions
    
    /// Called when a touch event enters the control’s bounds.
    @objc
    private func labelTapped(sender: UITapGestureRecognizer) {
        var calculatedIndex: Int?
        for (index, label) in labels.enumerated() where sender.view == label {
            calculatedIndex = index
        }
        
        // Trigger the selected index changed, only if the new selected index is different than the oldValue
        if let calculatedIndex = calculatedIndex, selectedIndex != calculatedIndex {
            setSelectedIndex(calculatedIndex)
            selectedIndexChanged?(selectedIndex)
        }
    }
    
}

