/*
 Proportioned.swift

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

  /// The result of `aspectRatio(_:contentMode:)`.
  @available(watchOS 6, *)
  public struct Proportioned<ContentView>: LegacyView where ContentView: LegacyView {

    // MARK: - Initialization

    internal init(
      contents: ContentView,
      aspectRatio: Double?,
      contentMode: SDGInterfaceBasics.ContentMode
    ) {
      self.contents = contents
      self.aspectRatio = aspectRatio
      self.contentMode = contentMode
    }

    // MARK: - Properties

    private var contents: ContentView
    private var aspectRatio: Double?
    private var contentMode: SDGInterfaceBasics.ContentMode

    // MARK: - LegacyView

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return AspectRatioContainer.constraining(
          contents,
          toAspectRatio: aspectRatio,
          contentMode: contentMode
        ).cocoaView
      }
    #elseif canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        return AspectRatioContainer.constraining(
          contents,
          toAspectRatio: aspectRatio,
          contentMode: contentMode
        ).cocoaView
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Proportioned: View where ContentView: View {

    // MARK: - View

    public var swiftUIView: some SwiftUI.View {
      return contents.swiftUIView.aspectRatio(
        aspectRatio.map({ CGFloat($0) }),
        contentMode: SwiftUI.ContentMode(contentMode)
      )
    }
  }
#endif
