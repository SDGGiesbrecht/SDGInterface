/*
 MenuBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#endif

import SDGMathematics
import SDGText
import SDGLocalization

import SDGInterfaceBasics
import SDGMenus

import SDGInterfaceLocalizations

/// An application’s menu bar.
///
/// `MenuBar` is a fully localized version of Interface Builder’s template with several useful additions.
///
/// Some menu items only appear if the application provides details they need to operate:
/// - “Preferences...” appears if the application has a preference manager.
/// - “Help” appears if a help book is specified in the `Info.plist` file.
///
/// - Note: The menu bar will only appear on the screen for platforms which actually have a menu bar. To reduce the need for `#if` statements, the `MenuBar` type and its public interface still exist on the remaining platforms, but it is empty and does nothing.
public final class MenuBar {

    // MARK: - Class Properties

    /// The menu bar.
    public static let menuBar: MenuBar = MenuBar()

    // MARK: - Initialization

    private init() {
        menu = Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Menu Bar"
            }
        })))
        #if canImport(AppKit)
        menu.entries = [
            .submenu(MenuBar.application()),
            .submenu(MenuBar.file()),
            .submenu(MenuBar.edit()),
            .submenu(MenuBar.format()),
            .submenu(MenuBar.view()),
            .submenu(MenuBar.window()),
            .submenu(MenuBar.help())
        ]
        #endif
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
        #if canImport(AppKit)
        NSApplication.shared.mainMenu = menu.native
        #endif
    }

    // MARK: - Modification

    /// Inserts a new submenu in the application‐specific section. (Before the “Window” menu.)
    ///
    /// - Parameters:
    ///     - submenu: The submenu.
    public func addApplicationSpecificSubmenu(_ submenu: AnyMenu) {
        let index: Int
        if menu.entries.count ≥ 2 {
            index = menu.entries.index(menu.entries.endIndex, offsetBy: −2)
        } else {
            index = 0
        }
        menu.entries.insert(.submenu(submenu), at: index)
    }

    // MARK: - Items

    #if canImport(AppKit)
    internal static func fallbackApplicationName(quotationMarks: (leading: StrictString, trailing: StrictString)) -> StrictString {
        var result = quotationMarks.leading
        result.append("\u{2068}")
        result.append(contentsOf: ApplicationNameForm.localizedIsolatedForm.resolved())
        result.append("\u{2069}")
        result.append(contentsOf: quotationMarks.trailing)
        return result
    }
    #endif
}
