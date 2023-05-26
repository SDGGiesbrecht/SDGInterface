/*
 AnyView.swift

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

  /// A type‐erased view.
  @available(watchOS 6, *)
  public struct AnyView: LegacyView {

    // MARK: - Initialization

    /// Creates a type‐erases version of the view.
    ///
    /// - Parameters:
    ///   - contents: The view to wrap.
    public init(_ contents: LegacyView) {
      legacyView = contents
    }

    // MARK: - Properties

    private let legacyView: LegacyView

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return legacyView.cocoa()
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension AnyView: View {

    // MARK: - View

    #if canImport(SwiftUI)
      public func swiftUI() -> SwiftUI.AnyView {
        return legacyView.swiftUIAnyView()
      }
    #endif
  }
#endif
