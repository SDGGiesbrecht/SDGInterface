/*
 AnyView.swift

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

  import SDGInterfaceBasics

  /// A type‐erased view.
  @available(watchOS 6, *)
  public struct AnyView: LegacyView {

    // MARK: - Initialization

    ///
    public init(_ contents: ContentView) {
      self.contents = contents
    }

    // MARK: - Properties

    private var contents: ContentView

    // MARK: - LegacyView

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return contents.cocoaView
      }
    #endif

    #if canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        return contents.cocoaView
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension AnyView: View {

    // MARK: - View

    public var swiftUIView: SwiftUI.AnyView {
      let swiftUI = contents.swiftUIView
      return (swiftUI as? SwiftUI.AnyView) ?? SwiftUI.AnyView(swiftUI)
    }
  }
#endif
