/*
 ContextMenu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
  import UIKit
#endif

import SDGLogic
import SDGText
import SDGLocalization

import SDGMenus

import SDGInterfaceLocalizations

/// A context menu.
public struct ContextMenu {
  #if canImport(UIKit) && !os(tvOS) && !os(watchOS)

    // MARK: - Initialization

    /// Creates a context menu.
    public init() {
      var entries: [MenuComponent] = [
        .entry(ContextMenu._normalizeText())
      ]
      if #available(iOS 9, *) {  // @exempt(from: unicode)
        entries.append(.entry(ContextMenu._showCharacterInformation()))
      }
      menu = Menu(
        label: UserFacing<StrictString, InterfaceLocalization>(
          { localization in  // @exempt(from: tests) Unreachable on iOS.
            switch localization {  // @exempt(from: tests)
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Context Menu"
            case .deutschDeutschland:
              return "Kontextmenü"
            }
          }),
        entries: entries
      )
    }

    // MARK: - Properties

    private let menu: AnyMenu

    #if canImport(UIKit)
      /// Generates a Cocoa representation of the context menu.
      public func cocoa() -> [UIMenuItem] {
        return menu.cocoa()
      }
    #endif
  #endif
}
