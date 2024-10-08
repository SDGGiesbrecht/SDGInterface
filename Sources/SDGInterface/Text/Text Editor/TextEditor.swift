/*
 TextEditor.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(tvOS) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow

  /// An editor for multiline text.
  public struct TextEditor: CocoaViewImplementation {

    // MARK: - Initialization

    /// Creates a multiline text editor.
    ///
    /// - Parameters:
    ///   - contents: The contents of the text editor.
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
        let cocoa = CocoaImplementation(
          contents: contents,
          transparentBackground: transparentBackground,
          logMode: false
        )
        cocoa.setEditability(true)
        return CocoaView(cocoa)
      }
    #endif
  }
#elseif os(tvOS)
  // Still used internally for namespacing.
  internal enum TextEditor {}
#endif
