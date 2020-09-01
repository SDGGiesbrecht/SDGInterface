/*
 TextField.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  extension TextField {

    #if canImport(AppKit)
      internal typealias Superclass = NSTextField
    #else
      internal typealias Superclass = UITextField
    #endif
    internal final class CocoaImplementation: Superclass, SharedValueObserver {
      #warning("Needs to validate menus.")

      // MARK: - Initialization

      internal init(contents: Shared<StrictString>) {
        self.contents = contents
        defer { contents.register(observer: self) }
        #if canImport(UIKit)
          defer {
            addTarget(self, action: #selector(contentsChanged), for: .editingChanged)
          }
        #endif

        super.init(frame: .zero)

        #if canImport(AppKit)
          isBordered = true
          isBezeled = true
          bezelStyle = .squareBezel
          drawsBackground = true
          lineBreakMode = .byClipping
          cell?.isScrollable = true
          cell?.usesSingleLineMode = true
          cell?.sendsActionOnEndEditing = true
          isSelectable = true
          isEditable = true
        #endif
        allowsEditingTextAttributes = false

        #if canImport(AppKit)
          font = NSFont.from(Font.forLabels)
        #elseif canImport(UIKit)
          font = UIFont.from(Font.forLabels)
        #endif
      }

      internal required init?(coder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let contents: Shared<StrictString>

      private var cocoaContents: String {
        get {
          #if canImport(AppKit)
            return stringValue
          #else
            return text ?? ""
          #endif
        }
        set {
          #if canImport(AppKit)
            stringValue = newValue
          #else
            text = newValue
          #endif
        }
      }

      // MARK: - Changes

      @objc private func contentsChanged() {
        if ¬contents.value.scalars.elementsEqual(cocoaContents.scalars) {
          contents.value = StrictString(cocoaContents)
        }
      }

      #if canImport(AppKit)
        // MARK: - NSTextField

        internal override func textDidChange(_ notification: Notification) {
          super.textDidChange(notification)
          contentsChanged()
        }
      #endif

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        if ¬cocoaContents.scalars.elementsEqual(contents.value) {
          cocoaContents = String(contents.value)
        }
      }
    }
  }
#endif
