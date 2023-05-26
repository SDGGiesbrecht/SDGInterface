/*
 CompatibilityLabel.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  /// A text label that preservers legacy characters in their noncanonical forms.
  @available(watchOS 6, *)
  public struct CompatibilityLabel<L>: LegacyView where L: Localization {

    // MARK: - Initialization

    /// Creates a label.
    ///
    /// - Parameters:
    ///   - text: The text of the label.
    ///   - colour: Optional. The colour of the text.
    public init(
      _ text: UserFacing<String, L>,
      colour: Colour = .black
    ) {
      self.init(Shared(text), colour: colour)
    }

    /// Creates a label.
    ///
    /// - Parameters:
    ///   - text: The text of the label.
    ///   - colour: Optional. The colour of the text.
    public init(
      _ text: Shared<UserFacing<String, L>>,
      colour: Colour = .black
    ) {
      genericLabel = GenericLabel(text, colour: colour)
    }

    // MARK: - Properties

    private let genericLabel: GenericLabel<L, String>

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return genericLabel.cocoa()
      }
    #endif
  }

  @available(watchOS 6, *)
  extension CompatibilityLabel: View {

    // MARK: - View

    #if canImport(SwiftUI)
      @available(macOS 10.15, tvOS 13, iOS 13, *)
      @ViewBuilder public func swiftUI() -> some SwiftUI.View {
        #if os(watchOS)
          genericLabel.swiftUI()
        #else
          if #available(macOS 12, tvOS 14, iOS 14, *) {
            genericLabel.swiftUI()
          } else {
            // @exempt(from: tests)
            cocoa().swiftUI()
          }
        #endif
      }
    #endif
  }
#endif
