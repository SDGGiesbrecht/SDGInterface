/*
 FullscreenWindow.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGControlFlow
import SDGText
import SDGLocalization

/// A window that begins in fullscreen mode.
public class FullscreenWindow<L> : PrimaryWindow<L> where L : Localization {

    /// Creates a fullscreen window.
    public override init(title: Shared<UserFacing<StrictString, L>>) {
        super.init(title: title)
        self.isFullscreen = true
    }
}

#endif
