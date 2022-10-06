/*
 ViewWithAlert.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGControlFlow
import SDGLocalization

/// A view with an associated alert.
public struct ViewWithAlert<V, L, M, N>: LegacyView
where V: LegacyView, L: Localization, M: Localization, N: Localization {

  // MARK: - Properties

  internal let view: V
  internal let alert: Alert<L, M, N>
  internal let isPresented: Shared<Bool>

  // MARK: - LegacyView

  #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
    public func cocoa() -> CocoaView {
      return CocoaView(CocoaImplementation(view: view, alert: alert, isPresented: isPresented))
    }
  #endif
}

@available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
extension ViewWithAlert: View, ViewShims where V: View {

  // MARK: - View

  #if canImport(SwiftUI)
    public func swiftUI() -> some SwiftUI.View {
      return SwiftUIImplementation(view: view, alert: alert, isPresented: isPresented)
    }
  #endif
}
