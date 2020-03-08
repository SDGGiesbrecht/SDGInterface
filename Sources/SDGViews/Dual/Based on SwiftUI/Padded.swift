/*
 Padded.swift

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

  /// The result of `padding(_:_:)`.
  @available(watchOS 6, *)
  public struct Padded<ContentView>: LegacyView where ContentView: LegacyView {

    // MARK: - Initialization

    internal init(contents: ContentView, edges: SDGInterfaceBasics.Edge.Set, width: Double?) {
      self.contents = contents
      self.edges = edges
      self.width = width
    }

    // MARK: - Properties

    private var contents: ContentView
    private var edges: SDGInterfaceBasics.Edge.Set
    private var width: Double?

    // MARK: - LegacyView

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return PaddingContainer(contents: contents, edges: edges, width: width).cocoaView
      }
    #endif

    #if canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        return PaddingContainer(contents: contents, edges: edges, width: width)
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Padded: View where ContentView: View {

    // MARK: - View

    public var swiftUIView: some SwiftUI.View {
      return contents.swiftUIView.padding(SwiftUI.Edge.Set(edges), width.map({ CGFloat($0) }))
    }
  }
#endif
