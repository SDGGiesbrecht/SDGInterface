/*
 ContextMenuEntries.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS) && !os(watchOS)
  import Foundation
  import ObjectiveC

  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  extension ContextMenu {

    public static func _normalizeText() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom:
            return "Normalise Text"
          case .englishUnitedStates, .englishCanada:
            return "Normalize Text"
          case .deutschDeutschland:
            return "Text normalisieren"
          }
        }),
        action: #selector(TextEditingResponder.normalizeText(_:)).action()
      )
    }

    public static func _showCharacterInformation() -> MenuEntry<InterfaceLocalization> {
      return MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Show Character Information"
          case .deutschDeutschland:
            return "Schriftzeicheninformationen einblenden"
          }
        }),
        action: #selector(TextDisplayResponder.showCharacterInformation(_:)).action()
      )
    }
  }
#endif
