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
  public struct Proportioned<Content>: LegacyView where Content: LegacyView {

    // MARK: - Initialization

    internal init(
      content: Content,
      aspectRatio: Double?,
      contentMode: SDGInterfaceBasics.ContentMode
    ) {
      self.content = content
      self.aspectRatio = aspectRatio
      self.contentMode = contentMode
    }

    // MARK: - Properties

    private let content: Content
    private let aspectRatio: Double?
    private let contentMode: SDGInterfaceBasics.ContentMode

    // MARK: - LegacyView

    #if !os(watchOS)
      private var nativeCocoaView: NativeCocoaView {
        return useSwiftUIOrFallback(to: {
          return AspectRatioContainer.constraining(
            content,
            toAspectRatio: aspectRatio,
            contentMode: contentMode
          ).cocoaView
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
  extension Proportioned: View, ViewShims where Content: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        return content.swiftUIView.aspectRatio(
          aspectRatio.map({ CGFloat($0) }),
          contentMode: SwiftUI.ContentMode(contentMode)
        )
      }
    #endif
  }
#endif
