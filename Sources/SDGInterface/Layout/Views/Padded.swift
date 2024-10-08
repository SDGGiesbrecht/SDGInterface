/*
 Padded.swift

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
#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

import SDGLogic

/// The result of `padding(_:_:)`.
@available(watchOS 6, *)
public struct Padded<Content>: LegacyView where Content: LegacyView {

  // MARK: - Initialization

  internal init(content: Content, edges: SDGInterface.Edge.Set, width: Double?) {
    self.content = content
    self.edges = edges
    self.width = width
  }

  // MARK: - Properties

  private let content: Content
  private let edges: SDGInterface.Edge.Set
  private let width: Double?

  // MARK: - LegacyView

  #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
    public func cocoa() -> CocoaView {
      return useSwiftUIOrFallback(to: {

        let content = self.content.cocoa()
        let container = CocoaView()

        func spacing(for edge: SDGInterface.Edge) -> Double? {
          var spacing = width
          if ¬edges.contains(Edge.Set(edge)) {
            spacing = 0
          }
          return spacing
        }
        container.fill(
          with: content,
          on: .horizontal,
          leadingMargin: spacing(for: .leading),
          trailingMargin: spacing(for: .trailing)
        )
        container.fill(
          with: content,
          on: .vertical,
          leadingMargin: spacing(for: .top),
          trailingMargin: spacing(for: .bottom)
        )

        return container
      })
    }
  #endif
}

@available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
extension Padded: View, ViewShims where Content: View {

  // MARK: - View

  #if canImport(SwiftUI)
    public func swiftUI() -> some SwiftUI.View {
      return content.swiftUI().padding(SwiftUI.Edge.Set(edges), width.map({ CGFloat($0) }))
    }
  #endif
}

#if canImport(SwiftUI)
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct PaddedPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      func square() -> SwiftUI.AnyView {
        return SwiftUI.AnyView(
          SwiftUI.Rectangle()
            .fill(Color.red)
            .frame(width: 32, height: 32)
        )
      }

      return Group {

        previewBothModes(
          square()
            .padding()
            .adjustForLegacyMode()
            .background(Color.blue),
          name: "Default"
        )

        previewBothModes(
          square()
            .padding(.horizontal, 16)
            .adjustForLegacyMode()
            .background(Color.blue),
          name: "Horizontal, 16"
        )
      }
    }
  }
#endif
