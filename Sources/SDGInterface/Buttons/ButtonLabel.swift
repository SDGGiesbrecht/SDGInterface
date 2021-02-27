/*
 ButtonLabel.swift

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

  import SDGText

  /// A button label.
  public enum ButtonLabel {

    /// Text.
    case text(StrictString)

    /// A symbol.
    case symbol(SDGInterface.Image)

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
      internal func swiftUI() -> some SwiftUI.View {
        switch self {
        case .text(let text):
          return SwiftUI.AnyView(Text(verbatim: String(text)))
        case .symbol(let symbol):
          return SwiftUI.AnyView(symbol.swiftUI())
        }
      }
    #endif
  }
#endif
