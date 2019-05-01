/*
 Window.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

import SDGInterfaceLocalizations

/// A window.
open class Window<L> : WindowPrototype, SharedValueObserver where L : Localization {

    // MARK: - Initialization

    /// Creates a window.
    ///
    /// - Parameters:
    ///     - title: The title of the window.
    ///     - size: The size of the window.
    ///     - additionalStyles: Window styles to opt into.
    ///     - disabledStyles: Window styles to opt out of.
    public init(
        title: Shared<UserFacing<StrictString, L>>,
        size: CGSize,
        additionalStyles: NSWindow.StyleMask = [],
        disabledStyles: NSWindow.StyleMask = []) {

        localizedTitle = title

        super.init(
            title: title.value.resolved(),
            size: size,
            additionalStyles: additionalStyles,
            disabledStyles: disabledStyles)

        finishInitialization(title: title)
    }

    #if canImport(UIKit)
    /// Creates a window.
    ///
    /// - Parameters:
    ///     - title: The title of the window.
    public init(title: Shared<UserFacing<StrictString, L>>) {
        localizedTitle = title
        super.init(title: title.value.resolved())
        finishInitialization(title: title)
    }
    #endif

    private func finishInitialization(title: Shared<UserFacing<StrictString, L>>) {
        title.register(observer: self)
        LocalizationSetting.current.register(observer: self)
    }

    // MARK: - Properties

    /// The title of the window.
    public var localizedTitle: Shared<UserFacing<StrictString, L>> {
        didSet {
            oldValue.cancel(observer: self)
            localizedTitle.register(observer: self)
        }
    }

    // MARK: - SharedValueObserver

    public func valueChanged(for identifier: String) {
        #if canImport(AppKit)
        title = String(localizedTitle.value.resolved())
        #endif
    }
}

#endif
