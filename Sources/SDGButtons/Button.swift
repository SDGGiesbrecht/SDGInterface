/*
 Button.swift

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
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGText
import SDGLocalization

import SDGInterfaceBasics
import SDGViews

/// A button.
public final class Button<L> : AnyButton, SpecificView where L : Localization {

    // MARK: - Initialization

    /// Creates a button.
    ///
    /// - Parameters:
    ///     - label: The label on the button.
    public init(label: Binding<StrictString, L>) {
        self.label = label
        defer {
            labelDidSet()
            LocalizationSetting.current.register(observer: bindingObserver)
        }

        #if canImport(AppKit)
        specificNative = NSButton()
        #elseif canImport(UIKit)
        specificNative = UILabel()
        #endif
        defer {
            bindingObserver.button = self
        }

        #if canImport(AppKit)
        specificNative.bezelStyle = .rounded
        specificNative.setButtonType(.momentaryPushIn)
        #endif

        specificNative.font = Font.forLabels.native
    }

    // MARK: - Properties

    private let bindingObserver = BindingObserver()

    /// The label.
    public var label: Binding<StrictString, L> {
        willSet {
            label.shared?.cancel(observer: bindingObserver)
        }
        didSet {
            labelDidSet()
        }
    }
    private func labelDidSet() {
        label.shared?.register(observer: bindingObserver)
    }

    // MARK: - Refreshing

    public func _refreshBindings() {
        let resolved = String(label.resolved())
        specificNative.title = resolved
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
    public let specificNative: NSButton
    #elseif canImport(UIKit)
    public let specificNative: UIButton
    #endif
}
#endif
