/*
 ButtonLabel.swift

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

  import SDGText

  import SDGViews
  import SDGImageDisplay

  /// A button label.
  public enum ButtonLabel {

    /// Text.
    case text(StrictString)

    /// A symbol.
    case symbol(SDGImageDisplay.Image)

    // MARK: - View

    #if canImport(SwiftUI)
      @available(macOS 10.15, *)
      internal func swiftUI() -> some SwiftUI.View {
        switch self {
        case .text(let text):
          return SwiftUI.AnyView(Text(verbatim: String(text)))
        case .symbol(let symbol):
          return SwiftUI.AnyView(SwiftUI.Image(nsImage: symbol.cocoa))
        }
      }
    #endif
  }
#endif
