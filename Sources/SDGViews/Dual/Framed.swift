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

  import SDGInterfaceBasics

  /// The result of `frame(minWidth:idealWidth:maxWidth:minHeight:idealHeight:maxHeight:alignment:)`.
  @available(watchOS 6, *)
  public struct Framed<ContentView>: LegacyView where ContentView: LegacyView {

    // MARK: - Initialization

    internal init(
      contents: ContentView,
      minWidth: Double?,
      idealWidth: Double?,
      maxWidth: Double?,
      minHeight: Double?,
      idealHeight: Double?,
      maxHeight: Double?,
      alignment: SDGInterfaceBasics.Alignment
    ) {
      self.contents = contents
      self.minWidth = minWidth
      self.idealWidth = idealWidth
      self.maxWidth = maxWidth
      self.minHeight = minHeight
      self.idealHeight = idealHeight
      self.maxHeight = maxHeight
      self.alignment = alignment
    }

    // MARK: - Properties

    private var contents: ContentView
    private var minWidth: Double?
    private var idealWidth: Double?
    private var maxWidth: Double?
    private var minHeight: Double?
    private var idealHeight: Double?
    private var maxHeight: Double?
    private var alignment: SDGInterfaceBasics.Alignment

    // MARK: - LegacyView

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return FrameContainer(
          contents: contents,
          minWidth: minWidth,
          idealWidth: idealWidth,
          maxWidth: maxWidth,
          minHeight: minHeight,
          idealHeight: idealHeight,
          maxHeight: maxHeight,
          alignment: alignment
        ).cocoaView
      }
    #elseif canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        return FrameContainer(
          contents: contents,
          minWidth: minWidth,
          idealWidth: idealWidth,
          maxWidth: maxWidth,
          minHeight: minHeight,
          idealHeight: idealHeight,
          maxHeight: maxHeight,
          alignment: alignment
        ).cocoaView
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Framed: View where ContentView: View {

    // MARK: - View

    public var swiftUIView: some SwiftUI.View {
      return contents.swiftUIView.frame(
        minWidth: minWidth.map({ CGFloat($0) }),
        idealWidth: idealWidth.map({ CGFloat($0) }),
        maxWidth: maxWidth.map({ CGFloat($0) }),
        minHeight: minHeight.map({ CGFloat($0) }),
        idealHeight: idealHeight.map({ CGFloat($0) }),
        maxHeight: maxHeight.map({ CGFloat($0) }),
        alignment: SwiftUI.Alignment(alignment)
      )
    }
  }
#endif
