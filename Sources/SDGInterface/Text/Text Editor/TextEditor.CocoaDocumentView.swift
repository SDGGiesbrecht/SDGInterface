/*
 TextEditor.CocoaDocumentView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if PLATFORM_HAS_COCOA_INTERFACE
  import Foundation
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  extension TextEditor {

    internal class CocoaDocumentView: CocoaTextView {

      // MARK: - Initialization

      internal init() {
        let prototype = CocoaTextView()
        super.init(frame: CGRect.zero, textContainer: prototype.textContainer)

        #if canImport(AppKit)
          maxSize = CGSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
          )
          isVerticallyResizable = true
          autoresizingMask = .width

          allowsUndo = true
          usesFindPanel = true
        #endif

        #if canImport(AppKit)
          isContinuousSpellCheckingEnabled = true
          isGrammarCheckingEnabled = true
        #else
          spellCheckingType = .yes
        #endif

        #if canImport(AppKit)
          isAutomaticSpellingCorrectionEnabled = false
        #else
          autocorrectionType = .no
        #endif

        #if canImport(AppKit)
          isAutomaticQuoteSubstitutionEnabled = true
        #else
          smartQuotesType = .yes
        #endif

        #if canImport(AppKit)
          isAutomaticDashSubstitutionEnabled = true
        #else
          smartDashesType = .yes
        #endif

        #if canImport(UIKit)
          autocapitalizationType = .none
        #endif

        #if canImport(AppKit)
          smartInsertDeleteEnabled = true
        #else
          smartInsertDeleteType = .yes
        #endif

        #if canImport(AppKit)
          isAutomaticTextReplacementEnabled = true
        #endif

        #if canImport(AppKit)
          isAutomaticLinkDetectionEnabled = false
          isAutomaticDataDetectionEnabled = false
        #elseif !os(tvOS)
          dataDetectorTypes = []
        #endif
      }

      internal required init?(coder: NSCoder) {  // @exempt(from: tests)
        super.init(coder: coder)
      }

      #if canImport(AppKit)
        // MARK: - NSMenuItemValidation

        internal override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
          if let action = menuItem.action,
            let known = canPerform(action: action)
          {
            return known
          }
          return super.validateMenuItem(menuItem)
        }
      #endif

      // MARK: - NSView

      #if canImport(AppKit)
        internal override class var defaultMenu: NSMenu? {
          return TextContextMenu.contextMenu.menu
        }
      #endif
    }
  }
#endif
