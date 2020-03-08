/*
 Layered.swift

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

  /// The result of `background(_:alignment:)`.
  @available(watchOS 6, *)
  public struct Layered<Foreground, Background>: LegacyView
  where Foreground: LegacyView, Background: LegacyView {

    // MARK: - Initialization

    internal init(
      foreground: Foreground,
      background: Background,
      alignment: SDGInterfaceBasics.Alignment
    ) {
      self.foreground = foreground
      self.background = background
      self.alignment = alignment
    }

    // MARK: - Properties

    private var foreground: Foreground
    private var background: Background
    private var alignment: SDGInterfaceBasics.Alignment

    // MARK: - LegacyView

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return BackgroundContainer(background: background, foreground: self, alignment: alignment)
          .cocoaView
      }
    #endif

    #if canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        return BackgroundContainer(background: background, foreground: self, alignment: alignment)
          .cocoaView
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Layered: View where Foreground: View, Background: View {

    // MARK: - View

    public var swiftUIView: some SwiftUI.View {
      return foreground.swiftUIView.background(
        background.swiftUIView,
        alignment: SwiftUI.Alignment(alignment)
      )
    }
  }
#endif
