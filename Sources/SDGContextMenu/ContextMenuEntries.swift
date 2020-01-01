/*
 ContextMenuEntries.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS) && !os(tvOS)
  import Foundation
  import ObjectiveC

  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics
  import SDGMenus

  import SDGInterfaceLocalizations

  extension ContextMenu {

    public static func _normalizeText() -> MenuEntry<InterfaceLocalization> {
      let normalizeText = MenuEntry(
        label: .static(
          UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom:
              return "Normalise Text"
            case .englishUnitedStates, .englishCanada:
              return "Normalize Text"
            case .deutschDeutschland:
              return "Text normalisieren"
            }
          })
        )
      )
      normalizeText.action = #selector(TextEditingResponder.normalizeText(_:))
      return normalizeText
    }

    @available(iOS 9, *)  // @exempt(from: unicode)
    public static func _showCharacterInformation() -> MenuEntry<InterfaceLocalization> {
      let showCharacterInformation = MenuEntry(
        label: .static(
          UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Show Character Information"
            case .deutschDeutschland:
              return "Schriftzeicheninformationen einblenden"
            }
          })
        )
      )
      showCharacterInformation.action = #selector(TextDisplayResponder.showCharacterInformation(_:))
      return showCharacterInformation
    }
  }
#endif
