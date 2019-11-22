/*
 TextFieldBindingObserver.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  import Foundation
  import SDGControlFlow

  @objc internal final class TextFieldBindingObserver: NSObject, SharedValueObserver {

    // MARK: - Properties

    internal weak var field: TextField?

    // MARK: - SharedValueObserver

    internal func valueChanged(for identifier: String) {
      field?.refreshBindings()
    }

    @objc internal func actionOccurred(
      _ sender: Any?
    ) {  // @exempt(from: tests) Unreachable in tests on iOS.
      field?.actionOccurred()
    }
  }
#endif
