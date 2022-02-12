/*
 LegacyApplication.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

import SDGLogic
import SDGLocalization

internal var usingSwiftUI = false

/// The subset of the `Application` protocol that can be conformed to even on platform versions preceding SwiftUI’s availability.
public protocol LegacyApplication: Service {

  /// The type of the main window.
  associatedtype MainWindow: LegacyWindow
  /// The application’s main window.
  var mainWindow: MainWindow { get }
}

extension LegacyApplication {

  // MARK: - Service

  public func _displayMainWindow() {
    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      if ¬usingSwiftUI {
        mainWindow.display()
      }
    #elseif DEBUG
      _ = mainWindow  // Eager execution to simplify testing.
    #endif
  }
}
