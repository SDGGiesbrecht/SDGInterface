/*
 GenericLabel.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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
    self.text = text
    self.colour = colour
  }

  // MARK: - Properties

  private let text: Shared<UserFacing<S, L>>
  private let colour: Colour

  // MARK: - LegacyView

  #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
    public func cocoa() -> CocoaView {
      return useSwiftUI3OrFallback(to: {
        return CocoaView(
          CocoaImplementation(text: text, colour: colour)
        )
      })
    }
  #endif
}

@available(macOS 12, watchOS 6, *)
extension GenericLabel: View {

  // MARK: - View

  #if canImport(SwiftUI)
    @available(tvOS 13, iOS 13, *)
    public func swiftUI() -> some SwiftUI.View {
      return SwiftUIImplementation(
        text: text,
        colour: SwiftUI.Color(colour),
        localization: LocalizationSetting.current
      )
    }
  #endif
}
