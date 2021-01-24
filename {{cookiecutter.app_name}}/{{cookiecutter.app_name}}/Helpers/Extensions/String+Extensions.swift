//
//  String+Extensions.swift
//  Stylee
//
//  Copyright © 2020 MadSeven. All rights reserved.
//


import Foundation
import MobileCoreServices
import UIKit

// MARK: - Localizable

extension String {
    
    static func localized(key: String, table: String? = nil) -> String {
        guard let table = table else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, tableName: table, comment: "")
    }
    
}

// MARK: - Capitalization

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}

// MARK: - Boolean value

extension String {
    
    var boolValue: Bool? {
        switch lowercased() {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
}

// MARK: - URL String

extension String {
    
    var isUrl: Bool {
        return self.prefix(8) == "https://"
            || self.prefix(7) == "http://"
    }
    
    var isColorHexString: Bool {
        return self.prefix(1) == "#"
    }
    
}

// MARK: - HTML

extension String {
    
    func simpleHTMLStringToAttributedString(
        color: UIColor? = R.color.primaryTextColor(),
        font: UIFont? = FontBook.regular.of(size: 12),
        boldFont: UIFont? = FontBook.bold.of(size: 12),
        underlineStyle: NSUnderlineStyle? = nil
    ) -> NSAttributedString? {
        var attributes = [NSAttributedString.Key: Any]()
        
        if let font = font {
            attributes[.font] = font
        }
        
        if let color = color {
            attributes[.foregroundColor] = color
        }
        
        var attributedString = NSAttributedString(string: self, attributes: attributes)
        
        if let boldFont = boldFont, let updatedString = attributedString.replaceHTMLTag("b", withAttributes: [.font: boldFont]) {
            attributedString = updatedString
        }
        
        if let underlineStyle = underlineStyle, let updatedString = attributedString.replaceHTMLTag("u", withAttributes: [.underlineStyle: underlineStyle]) {
            attributedString = updatedString
        }
        
        return attributedString
    }
 
}
 
extension NSAttributedString {

    func replaceHTMLTag(_ tag: String, withAttributes attributes: [NSAttributedString.Key: Any]) -> NSAttributedString? {
        
        guard let resultingText = mutableCopy() as? NSMutableAttributedString else {
            return nil
        }
        
        let openTag = "<\(tag)>"
        let closeTag = "</\(tag)>"
        var tagLoop = true
        
        while tagLoop {
            let plainString = resultingText.string as NSString
            let openTagRange = plainString.range(of: openTag)
            
            if openTagRange.length == 0 {
                tagLoop = false
                continue
            }
            
            let affectedLocation = openTagRange.location + openTagRange.length
            let searchRange = NSRange(location: affectedLocation, length: plainString.length - affectedLocation)
            let closeTagRange = plainString.range(of: closeTag, options: [], range: searchRange)
            
            resultingText.addAttributes(attributes, range: NSRange(location: affectedLocation, length: closeTagRange.location - affectedLocation))
            resultingText.deleteCharacters(in: closeTagRange)
            resultingText.deleteCharacters(in: openTagRange)
        }
        return resultingText as NSAttributedString
    }
}

// MARK: - MimeType

extension String {
    
    static func getMimeType(for fileExtension: String) -> String {
        guard
            let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension as NSString, nil)?.takeRetainedValue(),
            let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue()
        else {
            return "application/octet-stream"
        }

        return mimetype as String
    }
    
}
