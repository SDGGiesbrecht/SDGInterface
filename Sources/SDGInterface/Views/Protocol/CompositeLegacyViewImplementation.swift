/*
 CompositeLegacyViewImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)

  /// A view that is implemented as a composition of other view types.
  ///
  /// Conformance to this protocol can be declared in order to use default implementations for all the requirements of `SDGSwift.LegacyView`.
  @available(watchOS 6, *)
  public protocol CompositeLegacyViewImplementation: LegacyView {

    /// The type of the root of the composed view.
    associatedtype Composition: LegacyView

    /// Composes the view.
    func compose() -> Composition
  }

  @available(watchOS 6, *)
  extension CompositeLegacyViewImplementation {

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return compose().cocoa()
      }
    #endif
  }

#endif
