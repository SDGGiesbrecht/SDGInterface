/*
 Observable.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(Combine)
  import Combine
#endif

import SDGControlFlow

#warning("Move to SDGControlFlow? Or remove underscore?")
@available(macOS 10.15, *)
public final class _Observable<Value>: ObservableObject {

  // MARK: - Initialization

  public init(_ shared: Shared<Value>) {
    // Shared
    self.shared = shared
    self.observer = ObservableSharedValueObserver()
    defer {
      observer.observable = self
      shared.register(observer: observer)
    }

    // Published
    value = shared.value
    subscriber = $value.assign(to: \.value, on: shared)
  }

  // MARK: - Bindings

  fileprivate func sharedStateChanged() {
    if expectingRebound {
      expectingRebound = false
    } else {
      expectingRebound = true
      value = shared.value
    }
  }

  // MARK: - Properties

  private let shared: Shared<Value>
  private let observer: ObservableSharedValueObserver<Value>

  @Published public var value: Value
  private var subscriber: AnyCancellable?

  var expectingRebound: Bool = false
}

#warning("Move elsewhere.")
@available(macOS 10.15, *)
private class ObservableSharedValueObserver<Value>: SharedValueObserver {

  // MARK: - Properties

  internal weak var observable: _Observable<Value>?

  // MARK: - SharedValueObserver

  internal func valueChanged(for identifier: String) {
    observable?.sharedStateChanged()
  }
}
