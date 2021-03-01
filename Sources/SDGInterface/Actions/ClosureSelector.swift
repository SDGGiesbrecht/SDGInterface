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

internal class ClosureSelector: NSObject {

  // MARK: - Initialization

  internal init(action: @escaping () -> Void) {
    self.action = action
  }

  // MARK: - Properties

  private let action: () -> Void

  // MARK: - Selector

  @objc func send() {
    action()
  }
}
