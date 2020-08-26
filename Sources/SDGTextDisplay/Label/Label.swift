/*
 Label.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
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

  import SDGInterfaceBasics
  import SDGViews

  /// A text label.
  @available(watchOS 6, *)
  public struct Label<L>: LegacyView where L: Localization {

    // MARK: - Initialization

    /// Creates a label.
    ///
    /// - Parameters:
    ///   - text: The text of the label.
    ///   - colour: Optional. The colour of the text.
    public init(
      _ text: UserFacing<StrictString, L>,
      colour: Colour = .black
    ) {
      self.init(
        compatibilityText: UserFacing<String, L>({ String(text.resolved(for: $0)) }),
        colour: colour
      )
    }

    /// Creates a label which preserves legacy characters in their noncanonical forms.
    ///
    /// - Parameters:
    ///   - compatibilityText: The text of the label.
    ///   - colour: Optional. The colour of the text.
    public init(
      compatibilityText: UserFacing<String, L>,
      colour: Colour = .black
    ) {
      #if DEBUG
        _ = compatibilityText.resolved()  // Eager execution to simplify testing.
      #endif
      self.compatibilityText = compatibilityText
      self.colour = colour
    }

    // MARK: - Properties

    private let compatibilityText: UserFacing<String, L>
    private let colour: Colour

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return useSwiftUIOrFallback(to: {
          return CocoaView(
            CocoaImplementation(compatibilityText: compatibilityText, colour: colour)
          )
        })
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal typealias View = SDGViews.View
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Label: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        return SwiftUIImplementation(
          compatibilityText: compatibilityText,
          colour: SwiftUI.Color(colour),
          localization: LocalizationSetting.current
        )
      }
    #endif
  }
#endif
