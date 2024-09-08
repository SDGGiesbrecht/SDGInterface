/*
 Menu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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
public struct Menu<L, Components>: LegacyMenuComponents, LegacyCommands, MenuProtocol
where L: Localization, Components: LegacyMenuComponents {

  // MARK: - Initialization

  /// Creates a menu.
  ///
  /// - Parameters:
  ///     - label: The label.
  ///     - entries: The menu entries.
  public init(
    label: UserFacing<StrictString, L>,
    @MenuComponentsBuilder entries: () -> Components
  ) {
    #if DEBUG
      // Eager execution to simplify testing.
      _ = entries()
    #endif
    self.label = label
    self.entries = entries()
  }

  // MARK: - Properties

  private let label: UserFacing<StrictString, L>
  private let entries: Components

  // MARK: - LegacyCommands

  public func menuComponents() -> Self {
    return self
  }

  // MARK: - LegacyMenuComponents

  #if canImport(AppKit)
    public func cocoaMenu() -> NSMenu {
      return CocoaMenu(label: label, entries: entries)
    }
    public func cocoa() -> [NSMenuItem] {
      return [CocoaImplementation(label: label, entries: entries)]
    }
  #endif

  #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
    public func cocoa() -> [UIMenuItem] {
      return entries.cocoa()
    }
  #endif
}

@available(macOS 11, tvOS 13, iOS 14, watchOS 6, *)
extension Menu: Commands, MenuComponents where Components: SDGInterface.MenuComponents {

  // MARK: - Commands

  #if canImport(SwiftUI) && !os(tvOS) && !os(watchOS)
    public func swiftUICommands() -> some SwiftUI.Commands {
      return SwiftUICommandsImplementation(
        label: label,
        entries: entries,
        localization: LocalizationSetting.current
      )
    }
  #endif

  // MARK: - MenuComponents

  #if canImport(SwiftUI)
    public func swiftUI() -> some SwiftUI.View {
      return SwiftUIImplementation(
        label: label,
        entries: entries,
        localization: LocalizationSetting.current
      )
    }
  #endif
}

#if canImport(SwiftUI)
  @available(macOS 11, tvOS 13, iOS 14, watchOS 6, *)
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
        action: {}  // @exempt(from: tests)
      )

      let menu = Menu<
        InterfaceLocalization,
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<MenuEntry<InterfaceLocalization>, SDGInterface.Divider>,
          Menu<InterfaceLocalization, MenuEntry<InterfaceLocalization>>
        >
      >(
        label: UserFacing<StrictString, InterfaceLocalization>(
          { localization in  // @exempt(from: tests) Unreachable.
            switch localization {  // @exempt(from: tests)
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Menu"
            case .deutschDeutschland:
              return "Menü"
            }
          }),
        entries: {
          entry
          Divider()
          Menu(
            label: UserFacing<StrictString, InterfaceLocalization>({ localization in
              switch localization {
              case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Submenu"
              case .deutschDeutschland:
                return "Untermenü"
              }
            }),
            entries: {
              entry
            }
          )
        }
      )
      return Group {
        menu.swiftUI()
          .padding()
          .previewDisplayName("Menu")
      }
    }
  }
#endif
