/*
 SharedBinding.Observer.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SDGControlFlow

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension SharedBinding {

    internal class Observer<Value>: SharedValueObserver {

      // MARK: - Properties

      internal weak var binding: SharedBinding<Value>?

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        binding?.valueChanged()
      }
    }
  }
#endif
