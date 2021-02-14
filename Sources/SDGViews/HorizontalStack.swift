/*
 HorizontalStack.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGInterface

  /// A shimmed version of `SwiftUI.HStack` with relaxed availability constraints.
  @available(watchOS 6, *)
  public struct HorizontalStack<Entry>: LegacyView where Entry: LegacyView {

    // MARK: - Initialization

    /// A shimmed version of `SwiftUI.HStack.init(alignment:spacing:content:)` with relaxed availability constraints.
    ///
    /// - Parameters:
    ///   - alignment: The alignment.
    ///   - spacing: The spacing.
    ///   - content: The content.
    public init(
      alignment: SDGInterface.VerticalAlignment = .centre,
      spacing: Double? = nil,
      content: [Entry]
    ) {
      self.alignment = alignment
      self.spacing = spacing
      self.content = content
    }

    // MARK: - Properties

    private let alignment: SDGInterface.VerticalAlignment
    private let spacing: Double?
    private let content: [Entry]

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        #if canImport(AppKit)
          let view = NSStackView()
        #else
          let view = UIStackView()
        #endif
        for entry in content {
          #if canImport(AppKit)
            view.addView(entry.cocoa().native, in: .center)
          #else
            view.addArrangedSubview(entry.cocoa().native)
          #endif
        }
        switch alignment {
        case .top:
          view.alignment = .top
        case .centre:
          #if canImport(AppKit)
            view.alignment = .centerY
          #else
            view.alignment = .center
          #endif
        case .bottom:
          view.alignment = .bottom
        }
        if let specific = spacing {
          view.spacing = CGFloat(specific)
        }
        return CocoaView(view)
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension HorizontalStack: View, ViewShims where Entry: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
      public func swiftUI() -> some SwiftUI.View {
        return HStack(
          alignment: SwiftUI.VerticalAlignment(alignment),
          spacing: spacing.map({ CGFloat($0) }),
          content: {
            ForEach(content.indices) {
              // @exempt(from: tests) Inaccurate coverage result.
              self.content[$0].swiftUI()
            }
          }
        )
      }
    #endif
  }
#endif
