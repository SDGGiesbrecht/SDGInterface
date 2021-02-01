/*
 LegacyView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGViews

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  @available(watchOS 6, *)
  extension LegacyView {

    #if !os(watchOS)
      internal func useSwiftUI2OrFallback(to fallback: () -> CocoaView) -> CocoaView {
        return useSwiftUI2OrFallback(to: fallback, useFallbackRegardless: legacyMode)
      }
    #endif

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, tvOS 13, iOS 13, *)
      internal func adjustForLegacyMode() -> SwiftUI.AnyView {
        return resolved(usingCocoa: legacyMode)
      }
    #endif
  }
#endif
