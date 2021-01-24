//
//  UITableVIew+Extensions.swift
//  Stylee
//
//  Copyright © 2020 MadSeven. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Method helping us determine wether or not the row is the last one of the section
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: if it's or not the last row
    @objc
    func isLastRow(at indexPath: IndexPath) -> Bool {
        return (indexPath.row == numberOfRows(inSection: indexPath.section) - 1)
    }
    
    // MARK: - Register
    
    /// Register a `UITableViewHeaderFooterView` with the table view.
    ///
    /// - Parameter headerFooterClass: The class of the `UITableViewHeaderFooterView`
    ///   to register.
    func registerHeaderFooter(_ headerFooterClass: UITableViewHeaderFooterView.Type) {
        self.register(headerFooterClass, forHeaderFooterViewReuseIdentifier: identifierWithoutModule(headerFooterClass))
    }
    
    /// Register a `UITableViewCell` with the table view.
    ///
    /// - Parameter headerFooterClass: The class of the `UITableViewCell` to register.
    func registerCell(_ cellClass: UITableViewCell.Type) {
        self.register(cellClass, forCellReuseIdentifier: identifierWithoutModule(cellClass))
    }
    
    // MARK: - Reuse
    
    /// Dequeue a `UITableViewHeaderFooterView` of a given type at a provided index path.
    ///
    /// - Parameter withClass: The class of the `UITableViewHeaderFooterView`.
    ///
    /// - Returns: A header footer view of the given type.
    func dequeueReausableHeaderFooter<HeaderFooterView: UITableViewHeaderFooterView>(withClass headerFooterClass: HeaderFooterView.Type) -> HeaderFooterView? {
        return dequeueReusableHeaderFooterView(withIdentifier: identifierWithoutModule(headerFooterClass)) as? HeaderFooterView
    }
    
    /// Dequeue a `UITableViewCell` of a given type at a provided index path.
    ///
    /// - Parameters:
    ///   - withClass: The class of the `UITableViewCell`.
    ///   - indexPath: The index path of the cell to dequeue.
    ///
    /// - Returns: A cell of the given type.
    func dequeueReusableCell<Cell: UITableViewCell>(withClass cellClass: Cell.Type, for indexPath: IndexPath) -> Cell {
        // swiftlint:disable force_cast
        return dequeueReusableCell(withIdentifier: identifierWithoutModule(cellClass), for: indexPath) as! Cell
        // swiftlint:enable force_cast
    }
    
    // MARK: - Helper
    
    private func identifierWithoutModule(_ klass: AnyClass) -> String {
        return klass
            .description()
            .components(separatedBy: ".")
            .dropFirst()
            .joined(separator: ".")
    }
    
}

// MARK: - UITableView + Safe

extension UITableView {
    
    func safeReloadData() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func reloadSectionAnimated(section: Int) {
        DispatchQueue.main.async {
            self.beginUpdates()
            self.reloadSections(IndexSet(integer: section), with: .fade)
            self.endUpdates()
        }
    }
    
}
