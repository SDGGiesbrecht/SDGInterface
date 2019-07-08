/*
 NSTableCellView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit

import SDGViews

internal class NSTableCellView : AppKit.NSTableCellView {

    // MARK: - Initialization

    internal init(view: View) {
        self.view = view
        super.init(frame: .zero)
        let wrapped = AnyNativeView(self)
        wrapped.fill(with: view, on: .vertical, margin: .specific(0))
        wrapped.fill(with: view, on: .horizontal, margin: .specific(1))
    }

    internal required init?(coder decoder: NSCoder) { // @exempt(from: tests)
        return nil
    }

    // MARK: - Properties

    private let view: View
}
#endif
