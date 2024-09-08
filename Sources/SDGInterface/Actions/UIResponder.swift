/*
 UIResponder.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit) && !os(tvOS) && !os(watchOS)
  import UIKit

  extension UIResponder {

    @objc internal func executeClosureAction(_ sender: Any?) {
      if let actionSender = sender as? ClosureActionSender {
        actionSender.actionClosure()
      }
    }
  }
#endif
