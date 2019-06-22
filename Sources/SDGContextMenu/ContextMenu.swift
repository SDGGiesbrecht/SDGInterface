/*
 ContextMenu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
import UIKit
#endif

import SDGText
import SDGLocalization

import SDGMenus

import SDGInterfaceLocalizations

/// The context menu.
public final class ContextMenu {

    // MARK: - Class Properties

    /// The context menu.
    public static let contextMenu: ContextMenu = ContextMenu()

    // MARK: - Initialization

    private init() {
        menu = Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Context Menu"
            }
        })))
        menu.entries = [
            .entry(ContextMenu._normalizeText()),
            .entry(ContextMenu._showCharacterInformation())
        ]
        menuDidSet()
    }

    // MARK: - Properties

    /// The root menu.
    public var menu: AnyMenu {
        didSet {
            menuDidSet()
        }
    }
    private func menuDidSet() {
        #if canImport(UIKit)
        func flatten(_ menu: AnyMenu) -> [UIMenuItem] {
            return menu.entries.flatMap { (entry) -> [UIMenuItem] in
                switch entry {
                case .entry(let entry):
                    return [entry.native]
                case .submenu(let submenu):
                    return flatten(submenu)
                case .separator:
                    return []
                }
            }
        }
        UIMenuController.shared.menuItems = flatten(menu)
        #endif
    }
}
#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import UIKit

import SDGInterfaceLocalizations

extension UIMenuController {

    internal func extend() {

        #warning("Redesign.")
        var entries = UIMenuController.shared.menuItems ?? []
        entries.append(contentsOf: [
            MenuBar._normalizeText(),
            MenuBar._showCharacterInformation()
            ].map({ $0.native }))
        UIMenuController.shared.menuItems = entries

        UIMenuController.shared.update()
    }
}
#endif
