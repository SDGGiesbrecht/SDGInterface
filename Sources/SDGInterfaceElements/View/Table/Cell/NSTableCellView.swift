/*
 NSTableCellView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension NSTableCellView {

    /// Returns the minimum height necessary for the cell.
    public var minimumHeight: CGFloat {
        return fittingSize.height
    }

    /// Binds a subview’s property to a content property.
    public func bind(subview: NSView, keyPath: NSBindingName, to contentKeyPath: String, options: [NSBindingOption: Any]? = nil) {
        #warning("Rethink.")
        subview.bind(keyPath, to: self, withKeyPath: #keyPath(NSTableCellView.objectValue) + "." + contentKeyPath, options: options)
    }
}
