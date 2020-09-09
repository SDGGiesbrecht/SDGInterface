/*
 LabelledTextField.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGLocalization

  import SDGViews

  /// A text field with a label.
  @available(watchOS 6, *)
  public struct LabelledTextField<L>: LegacyView where L: Localization {

    // MARK: - Initialization

    /// Creates a text field with label and a text field instances.
    ///
    /// - Parameters:
    ///     - label: The label.
    ///     - field: Optional. A specific field.
    public init(label: Label<L>, field: TextField) {
      self.label = label
      self.field = field

    }

    // MARK: - Properties

    /// The label.
    public let label: Label<L>
    /// The field.
    public let field: TextField

    #if !os(watchOS)
      // MARK: - LegacyView

      public func cocoa() -> CocoaView {
        return useSwiftUIOrFallback(to: {
          let container = CocoaView()
          let cocoaLabel = label.cocoa()
          let cocoaField = field.cocoa()
          container.position(
            subviews: [cocoaLabel, cocoaField],
            inSequenceAlong: .horizontal,
            padding: nil,
            margin: 0
          )
          container.alignLastBaselines(ofSubviews: [cocoaLabel, cocoaField])
          container.fill(with: cocoaField, on: .vertical, margin: 0)
          return container
        })
      }
    #endif
  }

  // MARK: - View
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal typealias View = SDGViews.View
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension LabelledTextField: View {

    #if !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        return HStack(alignment: .firstTextBaseline) {
          label.swiftUI().fixedSize()
          field.swiftUI()
        }
      }
    #endif
  }
#endif
