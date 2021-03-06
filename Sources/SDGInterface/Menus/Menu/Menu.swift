/*
 Menu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
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
