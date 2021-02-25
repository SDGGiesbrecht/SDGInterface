/*
 GenericLabel.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  @available(watchOS 6, *)
  internal struct GenericLabel<L, S>: LegacyView where L: Localization, S: StringFamily {

    // MARK: - Initialization

    internal init(
      _ text: Shared<UserFacing<S, L>>,
      colour: Colour
    ) {
      #if DEBUG
        _ = text.value.resolved()  // Eager execution to simplify testing.
      #endif
      self.text = text
      self.colour = colour
    }

    // MARK: - Properties

    private let text: Shared<UserFacing<S, L>>
    private let colour: Colour

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        // #workaround(Swift 5.3.2, SwiftUI would be a step backward from AppKit or UIKit without the ability to interact properly with menus such as “Copy”.)
        #if !canImport(AppKit) && !canImport(UIKit)
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

  // #workaround(Swift 5.3.2, SwiftUI would be a step backward from AppKit or UIKit without the ability to interact properly with menus such as “Copy”.)
  #if !canImport(AppKit) && !(canImport(UIKit) && !os(watchOS))
    @available(watchOS 6, *)
    extension GenericLabel: View {

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
