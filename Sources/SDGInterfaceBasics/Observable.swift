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

  import SDGControlFlow
  import SDGLogic

  // #workaround(SDGCornerstone 5.0.0, Belongs in SDGCornerstone.)
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  public final class _Observable<Value>: ObservableObject where Value: Equatable {

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
      subscriber = $value.sink(receiveValue: { newValue in
        if newValue ≠ shared.value {
          shared.value = newValue
        }
      })
    }

    // MARK: - Bindings

    internal func sharedStateChanged() {
      if value ≠ shared.value {
        value = shared.value
      }
    }

    // MARK: - Properties

    private let shared: Shared<Value>
    private let observer: ObservableSharedValueObserver<Value>

    @Published public var value: Value
    private var subscriber: AnyCancellable?
  }
#endif
