/*
 Label.swift

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

  /// A text label.
  public final class Label<L>: AnyLabel, SpecificView where L: Localization {

    // MARK: - Initialization

    /// Creates a text label.
    ///
    /// - Parameters:
    ///     - text: The text of the label.
    public init(text: Binding<StrictString, L>) {
      self.text = text
      defer {
        textDidSet()
        LocalizationSetting.current.register(observer: bindingObserver)
      }

      #if canImport(AppKit)
        specificCocoaView = NSTextField()
      #elseif canImport(UIKit)
        specificCocoaView = UILabel(frame: .zero)
      #endif
      defer {
        bindingObserver.label = self
      }

      #if canImport(AppKit)
        specificCocoaView.isBordered = false
        specificCocoaView.isBezeled = false
        specificCocoaView.drawsBackground = false
      #endif
      specificCocoaView.lineBreakMode = .byTruncatingTail

      #if canImport(AppKit)
        if let cell = specificCocoaView.cell as? NSTextFieldCell {
          cell.isScrollable = false
          cell.usesSingleLineMode = true
        }

        specificCocoaView.isSelectable = true
        specificCocoaView.isEditable = false
      #endif

      specificCocoaView.font = Font.forLabels.native
    }

    // MARK: - Properties

    private let bindingObserver = LabelBindingObserver()

    /// The text.
    public var text: Binding<StrictString, L> {
      willSet {
        text.shared?.cancel(observer: bindingObserver)
      }
      didSet {
        textDidSet()
      }
    }
    private func textDidSet() {
      text.shared?.register(observer: bindingObserver)
    }

    // MARK: - Refreshing

    public func _refreshBindings() {
      let resolved = String(text.resolved())
      #if canImport(AppKit)
        specificCocoaView.stringValue = resolved
      #elseif canImport(UIKit)
        specificCocoaView.text = resolved
      #endif
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
      public let specificCocoaView: NSTextField
    #elseif canImport(UIKit)
      public let specificCocoaView: UILabel
    #endif
  }
#endif
