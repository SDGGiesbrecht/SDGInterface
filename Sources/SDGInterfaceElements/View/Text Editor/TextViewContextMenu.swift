/*
 TextViewContextMenu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if os(macOS)
import AppKit

import SDGControlFlow
import SDGLogic
import SDGText
import SDGLocalization

import SDGInterfaceBasics
import SDGMenus
import SDGContextMenu

import SDGInterfaceLocalizations


/// The context menu used by text views.
public final class TextContextMenu {

    // MARK: - Class Properties

    /// The context menu.
    public static let contextMenu: TextContextMenu = TextContextMenu()

    // MARK: - Initialization

    private init() {
        menu = Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in // @exempt(from: tests) Unreachable on iOS.
            switch localization { // @exempt(from: tests)
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Context Menu"
            }
        })))
        let systemMenu = Menu<InterfaceLocalization>(native: NSTextView.defaultMenu ?? NSMenu()) // @exempt(from: tests) Never nil.
        let adjustments: [MenuComponent] = [
            .entry(SDGContextMenu.ContextMenu._normalizeText()),
            .entry(SDGContextMenu.ContextMenu._showCharacterInformation())
        ]
        var appendix: [MenuComponent] = []
        for adjustment in adjustments {
            var handled = false
            defer {
                if ¬handled {
                    appendix.append(adjustment)
                }
            }
            switch adjustment {
            case .entry(let entry):
                if entry.native.action == #selector(TextEditingResponder.normalizeText(_:)),
                    let transformations = systemMenu.entries.lazy.compactMap({ $0.asSubmenu })
                        .first(where: { $0.entries.contains(
                            where: { $0.asEntry?.action == #selector(NSText.uppercaseWord(_:)) }) }) {
                    transformations.entries = transformations.entries.filter({ entry in
                        let action = entry.asEntry?.action
                        if action == #selector(NSText.uppercaseWord(_:))
                            ∨ action == #selector(NSText.lowercaseWord(_:))
                            ∨ action == #selector(NSText.capitalizeWord(_:)) {
                            return false
                        }
                        return true
                    })
                    transformations.entries.append(adjustment)
                    handled = true
                } else if entry.native.action == #selector(TextDisplayResponder.showCharacterInformation(_:)),
                    let transformations = systemMenu.entries.indices.lazy
                        .first(where: { index in
                            let submenu = systemMenu.entries[index].asSubmenu
                            return submenu?.entries.contains(
                                where: { $0.asEntry?.action == #selector(TextEditingResponder.normalizeText(_:)) }) ?? false
                        }) {
                    systemMenu.entries.insert(adjustment, at: transformations + 1)
                    handled = true
                }
            default:
                unreachable()
            }
        }
        menu.entries = systemMenu.entries + appendix
    }

    // MARK: - Properties

    /// The menu.
    public var menu: AnyMenu
}
#endif
