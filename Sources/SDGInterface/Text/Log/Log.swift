/*
 Log.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  /// A textual log.
  ///
  /// A log is a text view that displays a progress log or similar text content that will be repeatedly appended to over time. Whenever the content is modified, the log scrolls to the bottom on the assumption that that is where the latest entry has been appended.
  public struct Log: CocoaViewImplementation {

    // MARK: - Initialization

    /// Creates a log.
    ///
    /// - Parameters:
    ///   - contents: The contents of the log.
    ///   - transparentBackground: Optional. Pass `true` to make the background transparent.
    public init(
      contents: Shared<RichText>,
      transparentBackground: Bool = false
    ) {
      self.contents = contents
      self.transparentBackground = transparentBackground
    }

    // MARK: - Properties

    private let contents: Shared<RichText>
    private let transparentBackground: Bool

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        let cocoa = TextEditor.CocoaImplementation(
          contents: contents,
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
