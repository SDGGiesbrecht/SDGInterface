/*
 ClosureSelector.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

#if canImport(AppKit)
  import AppKit
#endif

import SDGLogic

internal class ClosureSelector: NSObject {

  // MARK: - Initialization

  internal init(action: @escaping () -> Void, isDisabled: @escaping () -> Bool) {
    self.action = action
    self.isDisabled = isDisabled
  }

  // MARK: - Properties

  private let action: () -> Void
  private let isDisabled: () -> Bool

  // MARK: - Selector

  @objc func send() {
    action()
  }
}

#if canImport(AppKit)
  extension ClosureSelector: NSMenuItemValidation {

    // MARK: - NSMenuItemValidation

    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
      return ¬isDisabled()
    }
  }
#endif
