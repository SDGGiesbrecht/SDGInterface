/*
 TextView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGLocalization

  import SDGInterface

  /// A view for displaying text that cannot be edited.
  public struct TextView<L>: CocoaViewImplementation where L: Localization {

    // MARK: - Initialization

    /// Creates a multiline text view.
    ///
    /// - Parameters:
    ///   - contents: The contents of the text view.
    ///   - transparentBackground: Optional. Pass `true` to make the background transparent.
    public init(
      contents: UserFacing<RichText, L>,
      transparentBackground: Bool = false
    ) {
      self.contents = contents
      self.transparentBackground = transparentBackground
    }

    // MARK: - Properties

    private let contents: UserFacing<RichText, L>
    private let transparentBackground: Bool

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return CocoaView(
          CocoaImplementation(
            contents: contents,
            transparentBackground: transparentBackground
          )
        )
      }
    #endif
  }
#endif
