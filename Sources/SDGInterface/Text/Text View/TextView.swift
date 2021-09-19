/*
 TextView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if PLATFORM_HAS_COCOA_INTERFACE
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

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

#if canImport(SwiftUI) && !(os(iOS) && arch(arm)) && !os(watchOS)
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct TextViewPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      Group {

        previewBothModes(
          TextView(
            contents: UserFacing<RichText, InterfaceLocalization>({ localization in
              switch localization {
              case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                .deutschDeutschland:
                let markup =
                  SemanticMarkup("e")
                  + SemanticMarkup("πi").superscripted()
                  + SemanticMarkup(" − 1 = 0")
                var text = RichText(markup.richText(font: Font.forLabels.resized(to: 32)))
                text.italicize(range: ..<text.index(text.startIndex, offsetBy: 3))
                return text
              }
            })
          ).adjustForLegacyMode(),
          name: "Default"
        )
      }
    }
  }
#endif
