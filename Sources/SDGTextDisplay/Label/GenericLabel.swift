/*
 GenericLabel.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  @available(watchOS 6, *)
  internal struct GenericLabel<L, S>: LegacyView where L: Localization, S: StringFamily {

    // MARK: - Initialization

    internal init(
      _ text: UserFacing<S, L>,
      colour: Colour
    ) {
      #if DEBUG
        _ = text.resolved()  // Eager execution to simplify testing.
      #endif
      self.text = text
      self.colour = colour
    }

    // MARK: - Properties

    private let text: UserFacing<S, L>
    private let colour: Colour

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        // #workaround(Swift 5.2.4, Would be a step backward on other platforms without the ability to interact properly with menus.)
        #if os(watchOS)
          return useSwiftUIOrFallback(to: {
            return CocoaView(
              CocoaImplementation(text: text, colour: colour)
            )
          })
        #else
          return CocoaView(
            CocoaImplementation(text: text, colour: colour)
          )
        #endif
      }
    #endif
  }

  // #workaround(Swift 5.2.4, Would be a step backward on other platforms without the ability to interact properly with menus.)
  #if os(watchOS)
    @available(watchOS 6, *)
    extension Label: View {

      // MARK: - View

      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        public func swiftUI() -> some SwiftUI.View {
          return SwiftUIImplementation(
            text: text,
            colour: SwiftUI.Color(colour),
            localization: LocalizationSetting.current
          )
        }
      #endif
    }
  #else
    extension GenericLabel: CocoaViewImplementation {}
  #endif
#endif
