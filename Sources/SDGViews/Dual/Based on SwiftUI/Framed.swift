/*
 Framed.swift

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

  import SDGLogic

  import SDGInterfaceBasics

  /// The result of `frame(minWidth:idealWidth:maxWidth:minHeight:idealHeight:maxHeight:alignment:)`.
  @available(watchOS 6, *)
  public struct Framed<Content>: LegacyView where Content: LegacyView {

    // MARK: - Initialization

    internal init(
      content: Content,
      minWidth: Double?,
      idealWidth: Double?,
      maxWidth: Double?,
      minHeight: Double?,
      idealHeight: Double?,
      maxHeight: Double?,
      alignment: SDGInterfaceBasics.Alignment
    ) {
      self.content = content
      self.minWidth = minWidth
      self.idealWidth = idealWidth
      self.maxWidth = maxWidth
      self.minHeight = minHeight
      self.idealHeight = idealHeight
      self.maxHeight = maxHeight
      self.alignment = alignment
    }

    // MARK: - Properties

    private let content: Content
    private let minWidth: Double?
    private let idealWidth: Double?
    private let maxWidth: Double?
    private let minHeight: Double?
    private let idealHeight: Double?
    private let maxHeight: Double?
    private let alignment: SDGInterfaceBasics.Alignment

    // MARK: - LegacyView

    #if !os(watchOS)
      private var nativeCocoaView: NativeCocoaView {
        return useSwiftUIOrFallback(to: {
          return FrameContainer(
            content: content,
            minWidth: minWidth,
            idealWidth: idealWidth,
            maxWidth: maxWidth,
            minHeight: minHeight,
            idealHeight: idealHeight,
            maxHeight: maxHeight,
            alignment: alignment
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
  extension Framed: View, ViewProtocolShims where Content: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public var swiftUIView: some SwiftUI.View {
        return content.swiftUIView.frame(
          minWidth: minWidth.map({ CGFloat($0) }),
          idealWidth: idealWidth.map({ CGFloat($0) }),
          maxWidth: maxWidth.map({ CGFloat($0) }),
          minHeight: minHeight.map({ CGFloat($0) }),
          idealHeight: idealHeight.map({ CGFloat($0) }),
          maxHeight: maxHeight.map({ CGFloat($0) }),
          alignment: SwiftUI.Alignment(alignment)
        )
      }
    #endif
  }
#endif
