/*
 TextViewContextMenu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#endif

import SDGControlFlow
import SDGText
import SDGLocalization

import SDGMenus
import SDGContextMenu

import SDGInterfaceLocalizations

extension TextView {

    internal final class ContextMenu {

        // MARK: - Class Properties

        /// The context menu.
        internal static let contextMenu: ContextMenu = ContextMenu()

        // MARK: - Initialization

        private init() {
            menu = Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Context Menu"
                }
            })))
            let systemMenu = Menu<InterfaceLocalization>(native: NSTextView.defaultMenu ?? NSMenu())
            var adjustments: [MenuComponent] = [
                .entry(SDGContextMenu.ContextMenu._normalizeText()),
                .entry(SDGContextMenu.ContextMenu._showCharacterInformation())
            ]
            menu.entries = systemMenu.entries + adjustments
        }

        // MARK: - Properties

        /// The root menu.
        public var menu: AnyMenu
    }
}
