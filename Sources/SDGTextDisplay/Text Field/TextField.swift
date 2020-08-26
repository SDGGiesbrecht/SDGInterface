/*
 TextField.swift

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

  import SDGControlFlow
  import SDGLogic
  import SDGText

  import SDGInterfaceBasics
  import SDGViews

  /// A text field.
  public final class TextField: CocoaViewImplementation {

    // MARK: - Static Set‐Up

    #if canImport(AppKit)
      private static let setUpFieldEditor: Void = {
        _getFieldEditor = {
          return FieldEditor()
        }
        _resetFieldEditors()
      }()
    #endif

    // MARK: - Initialization

    /// Creates a text field.
    public init() {
      #if canImport(AppKit)
        TextField.setUpFieldEditor
      #endif

      #if canImport(AppKit)
        cocoaField = NSTextField()
      #else
        cocoaField = CocoaTextField()
      #endif
      bindingObserver.field = self

      #if canImport(AppKit)
        let cell = NormalizingCell()
        cocoaField.cell = cell
      #endif

      #if canImport(AppKit)
        cocoaField.action = #selector(TextFieldBindingObserver.actionOccurred)
        cocoaField.target = bindingObserver
      #elseif canImport(UIKit)
        cocoaField.addTarget(
          bindingObserver,
          action: #selector(TextFieldBindingObserver.actionOccurred),
          for: .editingDidEnd
        )
      #endif

      #if canImport(AppKit)
        cocoaField.isBordered = true
        cocoaField.isBezeled = true
        cocoaField.bezelStyle = .squareBezel
        cocoaField.drawsBackground = true
        cocoaField.lineBreakMode = .byClipping
        cell.isScrollable = true
        cell.usesSingleLineMode = true
        cell.sendsActionOnEndEditing = true
        cocoaField.isSelectable = true
        cocoaField.isEditable = true
      #endif
      cocoaField.allowsEditingTextAttributes = false

      #if canImport(AppKit)
        cocoaField.font = NSFont.from(Font.forLabels)
      #elseif canImport(UIKit)
        cocoaField.font = UIFont.from(Font.forLabels)
      #endif
    }

    // MARK: - Properties

    #if canImport(AppKit)
      private let cocoaField: NSTextField
    #elseif canImport(UIKit)
      private let cocoaField: UITextField
    #endif

    private let bindingObserver = TextFieldBindingObserver()

    /// The value of the text field.
    public var value: Shared<StrictString> = Shared("") {
      willSet {
        value.cancel(observer: bindingObserver)
      }
      didSet {
        value.register(observer: bindingObserver)
      }
    }

    // MARK: - Refreshing

    internal func refreshBindings() {
      let resolved = String(value.value)
      #if canImport(AppKit)
        cocoaField.stringValue = resolved
      #elseif canImport(UIKit)
        cocoaField.text = resolved
      #endif
    }

    internal func actionOccurred() {  // @exempt(from: tests) Unreachable in tests on iOS.
      #if canImport(AppKit)
        let new = StrictString(cocoaField.stringValue)
      #elseif canImport(UIKit)
        let new = StrictString(cocoaField.text ?? "")
      #endif
      if new ≠ value.value {
        value.value = new
      }
    }

    // MARK: - LegacyView

    public func cocoa() -> CocoaView {
      return CocoaView(cocoaField)
    }
  }
#endif
