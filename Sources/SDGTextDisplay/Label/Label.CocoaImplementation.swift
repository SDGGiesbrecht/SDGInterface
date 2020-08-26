/*
 Label.CocoaImplementation.swift

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
  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics

  extension Label {

    #if canImport(AppKit)
      internal typealias Superclass = NSTextField
    #else
      internal typealias Superclass = UILabel
    #endif
    internal final class CocoaImplementation: Superclass, SharedValueObserver {

      // MARK: - Initialization

      internal init(compatibilityText: UserFacing<String, L>, colour: Colour) {
        self.compatibilityText = compatibilityText
        defer {
          LocalizationSetting.current.register(observer: self)
        }

        super.init(frame: .zero)

        #if canImport(AppKit)
          isBordered = false
          isBezeled = false
          drawsBackground = false
        #endif
        lineBreakMode = .byTruncatingTail

        #if canImport(AppKit)
          if let cell = cell as? NSTextFieldCell {
            cell.isScrollable = false
            cell.usesSingleLineMode = true
          }

          isSelectable = true
          isEditable = false
        #endif

        #if canImport(AppKit)
          font = NSFont.from(Font.forLabels)
        #elseif canImport(UIKit)
          font = UIFont.from(Font.forLabels)
        #endif

        #if canImport(AppKit)
          textColor = NSColor(colour)
        #elseif canImport(UIKit)
          textColor = UIColor(colour)
        #endif
      }

      internal required init?(coder decoder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let compatibilityText: UserFacing<String, L>

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        let resolved = compatibilityText.resolved()
        #if canImport(AppKit)
          stringValue = resolved
        #elseif canImport(UIKit)
          text = resolved
        #endif
      }
    }
  }
#endif
