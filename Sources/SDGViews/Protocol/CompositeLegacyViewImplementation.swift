/*
 CompositeLegacyViewImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A view that is implemented as a composition of other view types.
///
/// Conformance to this protocol can be declared in order to use default implementations for all the requirements of `SDGSwift.LegacyView`.
public protocol CompositeLegacyViewImplementation: LegacyView {
  associatedtype Composition: LegacyView
  func compose() -> Composition
}

extension CompositeLegacyViewImplementation {

  public func cocoa() -> CocoaView {
    return compose().cocoa()
  }
}
