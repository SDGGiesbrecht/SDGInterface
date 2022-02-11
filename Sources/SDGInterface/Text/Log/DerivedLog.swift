/*
 DerivedLog.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if PLATFORM_HAS_COCOA_INTERFACE
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow

  /// A textual log derived from other data.
  public struct DerivedLog<Source>: CocoaViewImplementation {

    // MARK: - Initialization

    /// Creates a log.
    ///
    /// - Parameters:
    ///   - source: The source of the data.
    ///   - derivation: A closure which derives the log from the data.
    ///   - sourceValue: The source value from which to derive the log.
    ///   - transparentBackground: Optional. Pass `true` to make the background transparent.
    public init(
      source: Shared<Source>,
      derivation: @escaping (_ sourceValue: Source) -> RichText,
      transparentBackground: Bool = false
    ) {
      self.source = source
      self.derivation = derivation
      self.transparentBackground = transparentBackground
    }

    // MARK: - Properties

    private let source: Shared<Source>
    private let derivation: (Source) -> RichText
    private let transparentBackground: Bool

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        let cocoa = DerivedLog.CocoaImplementation(
          source: source,
          derivation: derivation,
          transparentBackground: transparentBackground,
          logMode: true
        )
        #if !os(tvOS)
          cocoa.setEditability(false)
        #endif
        return CocoaView(cocoa)
      }
    #endif
  }
#endif
