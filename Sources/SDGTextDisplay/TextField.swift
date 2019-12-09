/*
 TextField.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
  public final class TextField: CocoaViewImplementation, SpecificView {

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
        specificCocoaView = NSTextField()
      #else
        specificCocoaView = CocoaTextField()
      #endif
      bindingObserver.field = self

      #if canImport(AppKit)
        let cell = NormalizingCell()
        specificCocoaView.cell = cell
      #endif

      #if canImport(AppKit)
        specificCocoaView.action = #selector(TextFieldBindingObserver.actionOccurred)
        specificCocoaView.target = bindingObserver
      #elseif canImport(UIKit)
        specificCocoaView.addTarget(
          bindingObserver,
          action: #selector(TextFieldBindingObserver.actionOccurred),
          for: .editingDidEnd
        )
      #endif

      #if canImport(AppKit)
        specificCocoaView.isBordered = true
        specificCocoaView.isBezeled = true
        specificCocoaView.bezelStyle = .squareBezel
        specificCocoaView.drawsBackground = true
        specificCocoaView.lineBreakMode = .byClipping
        cell.isScrollable = true
        cell.usesSingleLineMode = true
        cell.sendsActionOnEndEditing = true
        specificCocoaView.isSelectable = true
        specificCocoaView.isEditable = true
      #endif
      specificCocoaView.allowsEditingTextAttributes = false

      specificCocoaView.font = Font.forLabels.native
    }

    // MARK: - Properties

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
        specificCocoaView.stringValue = resolved
      #elseif canImport(UIKit)
        specificCocoaView.text = resolved
      #endif
    }

    internal func actionOccurred() {  // @exempt(from: tests) Unreachable in tests on iOS.
      #if canImport(AppKit)
        let new = StrictString(specificCocoaView.stringValue)
      #elseif canImport(UIKit)
        let new = StrictString(specificCocoaView.text ?? "")
      #endif
      if new ≠ value.value {
        value.value = new
      }
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
      public let specificCocoaView: NSTextField
    #elseif canImport(UIKit)
      public let specificCocoaView: UITextField
    #endif
  }
#endif
