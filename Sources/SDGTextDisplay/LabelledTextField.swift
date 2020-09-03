/*
 LabelledTextField.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics
  import SDGViews

  /// A text field with a label.
  public final class LabelledTextField<L>: CocoaViewImplementation where L: Localization {

    // MARK: - Initialization

    /// Creates a text field with label and a text field instances.
    ///
    /// - Parameters:
    ///     - label: The label.
    ///     - field: Optional. A specific field.
    public init(label: Label<L>, field: TextField) {
      self.label = label
      let cocoaLabel = label.cocoa()
      self.field = field
      let cocoaField = field.cocoa()
      container = CocoaView()
      container.position(
        subviews: [cocoaLabel, cocoaField],
        inSequenceAlong: .horizontal,
        padding: nil,
        margin: 0
      )
      container.alignLastBaselines(ofSubviews: [cocoaLabel, cocoaField])
      container.fill(with: cocoaField, on: .vertical, margin: 0)
    }

    // MARK: - Properties

    private let container: CocoaView

    /// The label.
    public let label: Label<L>
    /// The field.
    public let field: TextField

    // MARK: - View

    public func cocoa() -> CocoaView {
      return container.cocoa()
    }
  }
#endif
