//
//  HostTableViewCell.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

/**
 Use this cell when embedding a controller inside. Only set the hostedView and manage adding/removing child controller inside
 the controller displaying this cell.
 
 Find this way of doing in here:
 https://williamboles.me/hosting-viewcontrollers-in-cells/
 */

final class HostTableViewCell: UITableViewCell {
    
    /**
        Acts as backing-store property to the hostedView property.
        Holds a reference to the viewcontroller's view.
     */
    private weak var _hostedView: UIView? {
        didSet {
            if let oldValue = oldValue, oldValue.isDescendant(of: self) {
                oldValue.removeFromSuperview()
            }
            
            if let _hostedView = _hostedView {
                _hostedView.isUserInteractionEnabled = true
                contentView.addSubview(_hostedView, constraints: [
                    _hostedView.edgeAnchors |=| contentView.edgeAnchors
                ])
            }
        }
    }
    
    var hostedView: UIView? {
        get {
            guard _hostedView?.isDescendant(of: self) ?? false else {
                _hostedView = nil
                return nil
            }
            
            return _hostedView
        }
        set {
            _hostedView = newValue
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hostedView = nil
    }
    
}
