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
  public struct Padded<Content>: LegacyView where Content: LegacyView {

    // MARK: - Initialization

    internal init(content: Content, edges: SDGInterfaceBasics.Edge.Set, width: Double?) {
      self.content = content
      self.edges = edges
      self.width = width
    }

    // MARK: - Properties

    private let content: Content
    private let edges: SDGInterfaceBasics.Edge.Set
    private let width: Double?

    // MARK: - LegacyView

    #if !os(watchOS)
      private var nativeCocoaView: NativeCocoaView {
        return useSwiftUIOrFallback(to: {
          return PaddingContainer(content: content, edges: edges, width: width).cocoaView
        })
      }
    #endif

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return nativeCocoaView
      }
    #elseif canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        return nativeCocoaView
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Padded: View, ViewShims where Content: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        return content.swiftUI().padding(SwiftUI.Edge.Set(edges), width.map({ CGFloat($0) }))
      }
    #endif
  }
#endif
