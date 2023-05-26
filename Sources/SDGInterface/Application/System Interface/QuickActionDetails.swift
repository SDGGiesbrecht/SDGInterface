/*
 QuickActionDetails.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
  import UIKit
#endif

/// Details about a quick action.
public struct QuickActionDetails {

  // MARK: - Initialization

  /// Creates empty details.
  public init() {}

  // MARK: - Properties

  #if canImport(UIKit) && !os(tvOS) && !os(watchOS)
    /// Some systems specify the shortcut item.
    public var shortcutItem: UIApplicationShortcutItem? {
      get {
        return _shortcutItem as? UIApplicationShortcutItem
      }
      set {
        _shortcutItem = newValue
      }
    }
    private var _shortcutItem: Any?
  #endif
}
