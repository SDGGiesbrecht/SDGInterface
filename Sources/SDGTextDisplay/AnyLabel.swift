/*
 AnyLabel.swift

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

import SDGInterfaceBasics
import SDGViews

/// A label with no particular localization.
public protocol AnyLabel : View {
    #if canImport(AppKit)
    // #documentation(SpecificView.specificNative)
    var specificNative: NSTextField { get }
    #elseif canImport(UIKit)
    // #documentation(SpecificView.specificNative)
    var specificNative: UILabel { get }
    #endif
    func _refreshBindings()
}

extension AnyLabel {

    internal func refreshBindings() {
        _refreshBindings()
    }

    // MARK: - Properties

    /// The colour of the text.
    public var textColour: Colour? {
        get {
            return specificNative.textColor.map { Colour($0) }
        }
        set {
            #if canImport(AppKit)
            specificNative.textColor = newValue?.nsColor
            #elseif canImport(UIKit)
            specificNative.textColor = newValue?.uiColor
            #endif
        }
    }
}
#endif
