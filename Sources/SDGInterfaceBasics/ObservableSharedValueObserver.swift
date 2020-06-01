/*
 ObservableSharedValueObserver.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(Combine)
  import SDGControlFlow

  // #workaround(SDGCornerstone 5.0.0, Belongs in SDGCornerstone.)
  @available(macOS 10.15, *)
  internal class ObservableSharedValueObserver<Value>: SharedValueObserver {

    // MARK: - Properties

    internal weak var observable: _Observable<Value>?

    // MARK: - SharedValueObserver

    internal func valueChanged(for identifier: String) {
      observable?.sharedStateChanged()
    }
  }
#endif
