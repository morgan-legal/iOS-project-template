//
//  UICollectionView+Extensions.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /// Method helping us determine wether or not the row is the last one of the section
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: if it's or not the last row
    @objc func isLastRow(at indexPath: IndexPath) -> Bool {
        return (indexPath.row == self.numberOfItems(inSection: indexPath.section) - 1)
    }
    
    // MARK: - Register
    
    /// Register a `UICollectionViewCell` with the table view.
    ///
    /// - Parameter cellClass: The class of the `UICollectionViewCell` to register.
    func registerCell(_ cellClass: UICollectionViewCell.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: identifierWithoutModule(cellClass))
    }
    
    // MARK: - Reuse
    
    /// Dequeue a `UICollectionViewCell` of a given type at a provided index path.
    ///
    /// - Parameters:
    ///   - withClass: The class of the `UICollectionViewCell`.
    ///   - indexPath: The index path of the cell to dequeue.
    ///
    /// - Returns: A cell of the given type.
    func dequeueReusableCell<Cell: UICollectionViewCell>(withClass cellClass: Cell.Type, for indexPath: IndexPath) -> Cell {
        // swiftlint:disable force_cast
        return dequeueReusableCell(withReuseIdentifier: identifierWithoutModule(cellClass), for: indexPath) as! Cell
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
