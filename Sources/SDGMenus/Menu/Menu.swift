/*
 Menu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGText
  import SDGLocalization

  /// A menu.
  public struct Menu<L>: AnyMenu where L: Localization {

    // MARK: - Initialization

    /// Creates a menu.
    ///
    /// - Parameters:
    ///     - label: The label.
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

    // MARK: - AnyMenu

    public func cocoa() -> NSMenu {
      return CocoaImplementation(label: label, entries: entries)
    }
  }
#endif
