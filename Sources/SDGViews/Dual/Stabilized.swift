/*
 Stabilized.swift

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
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGInterfaceBasics

  /// The result of `stabilize(_:_:)`.
  @available(watchOS 6, *)
  public struct Stabilized<Content>: LegacyView where Content: LegacyView {

    // MARK: - Initialization

    internal init(content: Content) {
      self.content = content
      #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
        self.cocoaView = content.cocoa()
      #endif
    }

    // MARK: - Properties

    // Maintains any strong references outside the Cocoa view.
    private let content: Content

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      private let cocoaView: CocoaView
      public func cocoa() -> CocoaView {
        return cocoaView
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Stabilized: View, ViewShims where Content: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        return content.swiftUI()
      }
    #endif
  }
#endif
