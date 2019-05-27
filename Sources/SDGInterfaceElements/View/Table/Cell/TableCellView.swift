/*
 TableCellView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

#if canImport(AppKit)
// @documentation(TableCellView)
/// An alias for `NSTableCellView` or `UITableViewCell`.
public typealias TableCellView = NSTableCellView
#else
// #documentation(TableCellView)
/// An alias for `NSTableCellView` or `UITableViewCell`.
public typealias TableCellView = UITableViewCell
#endif

extension TableCellView {

    #if canImport(AppKit)
    /// Returns the minimum height necessary for the cell.
    @objc public var minimumHeight: CGFloat {
        return fittingSize.height
    }
    #endif

    #if canImport(AppKit)
    /// Binds a subview’s property to a content property.
    ///
    /// - Parameters:
    ///     - subview: The subview to bind.
    ///     - keyPath: The key path of the view’s property.
    ///     - contentKeyPath: The key path of the data objects property.
    ///     - options: Binding options.
    public func bind(subview: View, keyPath: NSBindingName, to contentKeyPath: String, options: [NSBindingOption: Any]? = nil) {
        subview.bind(keyPath, to: self, withKeyPath: #keyPath(NSTableCellView.objectValue) + "." + contentKeyPath, options: options)
    }
    #endif
}
#endif
