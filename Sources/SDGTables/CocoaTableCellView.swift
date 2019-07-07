/*
 CocoaTableCellView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGViews

#if canImport(AppKit)
internal typealias NSUITableCellView = NSTableCellView
#elseif canImport(UIKit)
internal typealias NSUITableCellView = NSTableCellView
#endif

internal class CocoaTableCellView : NSUITableCellView {

    // MARK: - Initialization

    internal init(view: View) {
        self.view = view
        super.init(frame: .zero)
        #warning("Needs to set up constraints.")
    }

    internal required init?(coder decoder: NSCoder) {
        return nil
    }

    // MARK: - Properties

    private let view: View?
}
#endif
