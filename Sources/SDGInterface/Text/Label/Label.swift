/*
 Label.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGInterfaceLocalizations

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
      self.init(Shared(text), colour: colour)
    }

    /// Creates a label.
    ///
    /// - Parameters:
    ///   - text: The text of the label.
    ///   - colour: Optional. The colour of the text.
    public init(
      _ text: Shared<UserFacing<StrictString, L>>,
      colour: Colour = .black
    ) {
      genericLabel = GenericLabel(text, colour: colour)
    }

    // MARK: - Properties

    private let genericLabel: GenericLabel<L, StrictString>

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return genericLabel.cocoa()
      }
    #endif
  }

  // #workaround(Swift 5.3.2, SwiftUI would be a step backward from AppKit or UIKit without the ability to interact properly with menus such as “Copy”.)
  #if !canImport(AppKit) && !(canImport(UIKit) && !os(watchOS))
    @available(watchOS 6, *)
    extension Label: View {

      // MARK: - View

      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        public func swiftUI() -> some SwiftUI.View {
          return genericLabel.swiftUI()
        }
      #endif
    }
  #else
    extension Label: CocoaViewImplementation {}
  #endif
#endif

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct LabelPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      Group {

        previewBothModes(
          Label(
            UserFacing<StrictString, InterfaceLocalization>({ localization in
              switch localization {
              case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Black"
              case .deutschDeutschland:
                return "Schwarz"
              }
            })
          ).adjustForLegacyMode(),
          name: "Default"
        )

        previewBothModes(
          Label(
            UserFacing<StrictString, InterfaceLocalization>({ localization in
              switch localization {
              case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Red"
              case .deutschDeutschland:
                return "Rot"
              }
            }),
            colour: .red
          ).adjustForLegacyMode(),
          name: "Red"
        )
      }
    }
  }
#endif
