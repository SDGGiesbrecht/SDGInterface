/*
 SharedBinding.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI

  import SDGControlFlow

  #warning("SDGCornerstone?")
  /// The unification of a `Shared` value and a SwiftUI `Binding`.
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  public final class SharedBinding<T> {

    // MARK: - Initialization

    /// Creates a shared binding.
    ///
    /// - Parameters:
    ///   - shared: The shared value.
    public init(_ shared: Shared<T>) {
      self.shared = shared
      self.binding = SwiftUI.Binding(get: { shared.value }, set: { shared.value = $0 })

      self.observer = Observer()
      defer { observer.binding = self }
    }

    // MARK: - Properties

    /// The shared value.
    public let shared: Shared<T>
    /// The binding.
    public var binding: SwiftUI.Binding<T>

    private let observer: Observer<T>

    // MARK: - Updating

    internal func valueChanged() {
      binding.update()
    }
  }
#endif
