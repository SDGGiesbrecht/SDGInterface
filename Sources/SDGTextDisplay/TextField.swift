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
  public final class TextField: CocoaViewImplementation, View {

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
        nativeField = NSTextField()
      #else
        nativeField = CocoaTextField()
      #endif
      bindingObserver.field = self

      #if canImport(AppKit)
        let cell = NormalizingCell()
        nativeField.cell = cell
      #endif

      #if canImport(AppKit)
        nativeField.action = #selector(TextFieldBindingObserver.actionOccurred)
        nativeField.target = bindingObserver
      #elseif canImport(UIKit)
        nativeField.addTarget(
          bindingObserver,
          action: #selector(TextFieldBindingObserver.actionOccurred),
          for: .editingDidEnd
        )
      #endif

      #if canImport(AppKit)
        nativeField.isBordered = true
        nativeField.isBezeled = true
        nativeField.bezelStyle = .squareBezel
        nativeField.drawsBackground = true
        nativeField.lineBreakMode = .byClipping
        cell.isScrollable = true
        cell.usesSingleLineMode = true
        cell.sendsActionOnEndEditing = true
        nativeField.isSelectable = true
        nativeField.isEditable = true
      #endif
      nativeField.allowsEditingTextAttributes = false

      nativeField.font = Font.forLabels.native
    }

    // MARK: - Properties

    #if canImport(AppKit)
      private let nativeField: NSTextField
    #elseif canImport(UIKit)
      private let nativeField: UITextField
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
        nativeField.stringValue = resolved
      #elseif canImport(UIKit)
        nativeField.text = resolved
      #endif
    }

    internal func actionOccurred() {  // @exempt(from: tests) Unreachable in tests on iOS.
      #if canImport(AppKit)
        let new = StrictString(nativeField.stringValue)
      #elseif canImport(UIKit)
        let new = StrictString(nativeField.text ?? "")
      #endif
      if new ≠ value.value {
        value.value = new
      }
    }

    // MARK: - LegacyView

    public func cocoa() -> CocoaView {
      return CocoaView(nativeField)
    }
  }
#endif
