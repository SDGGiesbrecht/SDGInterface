/*
 LegacyView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGInterface

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  @available(watchOS 6, *)
  extension LegacyView {

    #if !os(watchOS)
      internal func useSwiftUIOrFallback(to fallback: () -> CocoaView) -> CocoaView {
        return useSwiftUIOrFallback(to: fallback, useFallbackRegardless: legacyMode)
      }
    #endif

    #if !os(watchOS)
      internal func useSwiftUI2OrFallback(to fallback: () -> CocoaView) -> CocoaView {
        return useSwiftUI2OrFallback(to: fallback, useFallbackRegardless: legacyMode)
      }
    #endif

    #if canImport(SwiftUI)
      @available(macOS 10.15, tvOS 13, iOS 13, *)
      internal func adjustForLegacyMode() -> SwiftUI.AnyView {
        return resolved(usingCocoa: legacyMode)
      }
    #endif
  }
#endif
