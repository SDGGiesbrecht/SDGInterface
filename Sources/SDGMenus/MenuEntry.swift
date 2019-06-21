/*
 MenuEntry.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGInterfaceBasics

/// A menu entry.
public final class MenuEntry<L> : AnyMenuEntry, SharedValueObserver where L : Localization {

    // MARK: - Initialization

    /// Creates a menu entry.
    ///
    /// - Parameters:
    ///     - label: The label.
    public init(label: Binding<StrictString, L>) {
        self.label = label
        labelDidSet()
        LocalizationSetting.current.register(observer: self)
    }

    // MARK: - Properties

    /// The label.
    public var label: Binding<StrictString, L> {
        willSet {
            label.shared?.cancel(observer: self)
        }
        didSet {
            labelDidSet()
        }
    }
    private func labelDidSet() {
        label.shared?.register(observer: self)
    }

    // MARK: - Refreshing

    private func refreshNative() {
        refreshLabel()
    }
    private func refreshLabel() {
        #if !os(watchOS)
        native.title = String(label.resolved())
        #endif
    }

    // MARK: - AnyMenuEntry

    #if canImport(AppKit)
    public var native: NSMenuItem = NSMenuItem() {
        didSet {
            refreshNative()
        }
    }
    #elseif canImport(UIKit)
    #if !os(watchOS)
    public var native: UIMenuItem = UIMenuItem() {
        didSet {
            refreshNative()
        }
    }
    #endif
    public var _tag: Int = 0
    #endif

    // MARK: - SharedValueObserver

    public func valueChanged(for identifier: String) {
        refreshLabel()
    }
}
