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

  /// Stabilizes a view to behave with consistent reference semantics.
  ///
  /// Wrap unknown `View` conformers in this type before using repeated accesses of `cocoaView` that assume the same instance will be returned each time.
  @available(watchOS 6, *)
  public struct Stabilized<ContentView>: LegacyView where ContentView: LegacyView {

    // MARK: - Initialization

    internal init(contents: ContentView) {
      self.contents = contents
      #if canImport(AppKit)
        self.cocoaView = contents.cocoaView
      #endif
      #if canImport(UIKit)
        self.cocoaView = contents.cocoaView
      #endif
    }

    // MARK: - Properties

    // Maintains any strong references outside the Cocoa view.
    private var contents: ContentView

    // MARK: - LegacyView

    #if canImport(AppKit)
      public var cocoaView: NSView
    #endif

    #if canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Stabilized: View where ContentView: View {

    // MARK: - View

    public var swiftUIView: some SwiftUI.View {
      return contents.swiftUIView
    }
  }
#endif
