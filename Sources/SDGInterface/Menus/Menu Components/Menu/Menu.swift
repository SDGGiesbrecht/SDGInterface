/*
 Menu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
    // #workaround(Swift 5.3.3, Should be @MenuComponentsBuilder.)
    entries: () -> Components
  ) {
    #if DEBUG
      // Eager execution to simplify testing.
      _ = label.resolved()
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

  #if canImport(SwiftUI) && !os(tvOS) && !(os(iOS) && arch(arm)) && !os(watchOS)
    public func swiftUICommands() -> some SwiftUI.Commands {
      return SwiftUICommandsImplementation(
        label: label,
        entries: entries,
        localization: LocalizationSetting.current
      )
    }
  #endif

  // MARK: - MenuComponents

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    public func swiftUI() -> some SwiftUI.View {
      return SwiftUIImplementation(
        label: label,
        entries: entries,
        localization: LocalizationSetting.current
      )
    }
  #endif
}

#if canImport(SwiftUI) && !os(tvOS) && !os(watchOS) && !(os(iOS) && arch(arm))
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
        action: {}
      )

      #if !canImport(AppKit)
        typealias Entries = MenuEntry<InterfaceLocalization>
      #else
        typealias Entries = MenuComponentsConcatenation<
          MenuComponentsConcatenation<MenuEntry<InterfaceLocalization>, Divider>,
          Menu<InterfaceLocalization, MenuEntry<InterfaceLocalization>>
        >
      #endif
      let menu = Menu<InterfaceLocalization, Entries>(
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
          #if !canImport(AppKit)
            return MenuComponentsBuilder.buildBlock(entry)
          #else
            return MenuComponentsBuilder.buildBlock(
              entry,
              Divider(),
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
            )
          #endif
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
