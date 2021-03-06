/*
 Menu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(SwiftUI) && !os(tvOS)) || canImport(AppKit) || (canImport(UIKit) && !os(tvOS))
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  /// A menu.
  public struct Menu<L>: AnyMenu where L: Localization {

    // MARK: - Initialization

    /// Creates a menu.
    ///
    /// - Parameters:
    ///     - label: The label.
    ///     - entries: The menu entries.
    public init(
      label: UserFacing<StrictString, L>,
      entries: [MenuComponent]
    ) {
      self.label = label
      self.entries = entries
    }

    // MARK: - Properties

    private let label: UserFacing<StrictString, L>
    private let entries: [MenuComponent]

    // MARK: - SwiftUI

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      /// Creates the menu in SwiftUI.
      @available(macOS 11, *)
      public func swiftUI() -> some SwiftUI.View {
        return SwiftUIImplementation(
          label: label,
          entries: entries,
          localization: LocalizationSetting.current
        )
      }

      @available(macOS 11, *)
      public func swiftUIAnyView() -> SwiftUI.AnyView {
        return SwiftUI.AnyView(swiftUI())
      }
    #endif

    // MARK: - AnyMenu

    #if canImport(AppKit)
      public func cocoa() -> NSMenu {
        return CocoaImplementation(label: label, entries: entries)
      }
    #endif

    #if canImport(UIKit)
      public func cocoa() -> [UIMenuItem] {
        return entries.map { $0.cocoa() }
      }
    #endif
  }
#endif

#if canImport(SwiftUI) && !os(tvOS) && !(os(iOS) && arch(arm))
  @available(macOS 11, tvOS 14, iOS 14, watchOS 6, *)
  internal struct MenuPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      let entry = MenuEntry(
        label: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "Entry"
          case .deutschDeutschland:
            return "Eintrag"
          }
        }),
        action: {}
      )

      return Group {

        Menu(
          label: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Menu"
            case .deutschDeutschland:
              return "Menü"
            }
          }),
          entries: [
            .entry(entry),
            .separator,
            .submenu(
              Menu(
                label: UserFacing<StrictString, InterfaceLocalization>({ localization in
                  switch localization {
                  case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Submenu"
                  case .deutschDeutschland:
                    return "Untermenü"
                  }
                }),
                entries: [
                  .entry(entry)
                ]
              )
            ),
          ]
        ).swiftUI()
          .padding()
          .previewDisplayName("Menu")
      }
    }
  }
#endif
