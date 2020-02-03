/*
 HorizontalStack.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #elseif canImport(UIKit)
    import UIKit
  #endif

  import SDGInterfaceBasics

  /// A shimmed version of `SwiftUI.HStack` with no availability constraints.
  public struct HorizontalStack: View {

    // MARK: - Initialization

    /// A shimmed version of `SwiftUI.HStack.init(alignment:spacing:content:)` with no availability constraints.
    ///
    /// - Parameters:
    ///   - alignment: The alignment.
    ///   - spacing: The spacing.
    ///   - content: The content.
    public init(
      alignment: SDGInterfaceBasics.VerticalAlignment = .centre,
      spacing: Double? = nil,
      content: [View]
    ) {
      self.alignment = alignment
      self.spacing = spacing
      self.content = content
    }

    // MARK: - Properties

    private let alignment: SDGInterfaceBasics.VerticalAlignment
    private let spacing: Double?
    private let content: [View]

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, tvOS 13, iOS 13, *)
      public var swiftUIView: AnyView {
        return AnyView(
          HStack(
            alignment: SwiftUI.VerticalAlignment(alignment),
            spacing: spacing.map({ CGFloat($0) }),
            content: {
              ForEach(content.indices) { self.content[$0].swiftUIView }
            }
          )
        )
      }
    #endif

    #if canImport(AppKit)
      public var cocoaView: NSView {
        let view = NSStackView(views: content.map({ $0.cocoaView }))
        switch alignment {
        case .top:
          view.alignment = .top
        case .centre:
          view.alignment = .centerY
        case .bottom:
          view.alignment = .bottom
        }
        if let specific = spacing {
          view.spacing = CGFloat(specific)
        }
        return view
      }
    #elseif canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        let view = UIStackView(views: content.map({ $0.cocoaView }))
        switch alignment {
        case .top:
          view.alignment = .top
        case .centre:
          view.alignment = .centerY
        case .bottom:
          view.alignment = .bottom
        }
        if let specific = spacing {
          view.spacing = CGFloat(specific)
        }
        return view
      }
    #endif
  }
#endif
