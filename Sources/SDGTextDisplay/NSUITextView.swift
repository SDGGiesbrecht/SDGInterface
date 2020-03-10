/*
 NSUITextView.swift

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

  import SDGLogic
  import SDGCollections

  import SDGViews
  import SDGInterfaceBasics

  #if canImport(AppKit)
    internal typealias NSUITextView = NSTextView
  #elseif canImport(UIKit)
    internal typealias NSUITextView = UITextView
  #endif

  extension NSUITextView: RichTextEditingResponder {

    // MARK: - Selection

    internal func selectionRectangle() -> Rectangle? {
      #if canImport(AppKit)
        guard let layout = layoutManager,
          let text = textContainer
        else {
          return nil  // @exempt(from: tests)
        }
        let range = layout.glyphRange(forCharacterRange: selectedRange(), actualCharacterRange: nil)
        return Rectangle(layout.boundingRect(forGlyphRange: range, in: text))
      #else
        guard let range = selectedTextRange else {
          return nil  // @exempt(from: tests)
        }
        return selectionRects(for: range).first.map { Rectangle($0.rect) }
      #endif
    }

    // MARK: - Editing

    private func attemptToModifySelection(
      _ modify: (_ previousValue: NSAttributedString) -> NSAttributedString
    ) {
      let possibleStorage: NSTextStorage? = textStorage
      guard let storage = possibleStorage else {
        return  // @exempt(from: tests)
      }

      let originalRange: NSRange
      #if canImport(AppKit)
        originalRange = selectedRange()
      #else
        originalRange = selectedRange
      #endif
      var adjustedRange = NSRange(location: NSNotFound, length: NSNotFound)

      let possibleOriginal: NSAttributedString?
      #if canImport(AppKit)
        possibleOriginal = attributedSubstring(
          forProposedRange: originalRange,
          actualRange: &adjustedRange
        )
      #else
        possibleOriginal = textStorage.attributedSubstring(from: originalRange)
      #endif
      if let original = possibleOriginal {

        if adjustedRange.location == NSNotFound {
          adjustedRange = originalRange  // @exempt(from: tests)
        }

        let result = modify(original)
        let rawResult = result.string
        let shouldChange: Bool
        #if canImport(AppKit)
          shouldChange = shouldChangeText(in: adjustedRange, replacementString: rawResult)
        #else
          if ¬responds(to: #selector(TextView.shouldChangeText)) {
            shouldChange = true
          } else {
            guard let textRange = selectedTextRange else {  // @exempt(from: tests)
              return
            }
            shouldChange = shouldChangeText(in: textRange, replacementText: rawResult)
          }
        #endif
        if shouldChange {
          storage.replaceCharacters(in: adjustedRange, with: result)
          #if canImport(AppKit)
            didChangeText()
          #endif
        }
      }
    }
    private func attemptToMutateSelection(_ mutate: (NSMutableAttributedString) -> Void) {
      attemptToModifySelection {
        let selection = $0.mutableCopy() as! NSMutableAttributedString
        mutate(selection)
        return selection.copy() as! NSAttributedString
      }
    }

    // MARK: - Menu Validation

    private static let actionsRequiringSelection: Set<Selector> = {
      var result: Set<Selector> = [
        #selector(TextEditingResponder.normalizeText(_:)),
        #selector(RichTextEditingResponder.makeSuperscript(_:)),
        #selector(RichTextEditingResponder.makeSubscript(_:)),
        #selector(RichTextEditingResponder.resetBaseline(_:))
      ]
      if #available(iOS 9, *) {  // @exempt(from: unicode)
        result.insert(#selector(TextDisplayResponder.showCharacterInformation(_:)))
      }
      #if canImport(AppKit)
        result ∪= [
          #selector(RichTextEditingResponder.resetCasing(_:)),
          #selector(RichTextEditingResponder.makeLatinateUpperCase(_:)),
          #selector(RichTextEditingResponder.makeTurkicUpperCase(_:)),
          #selector(RichTextEditingResponder.makeLatinateSmallCaps(_:)),
          #selector(RichTextEditingResponder.makeTurkicSmallCaps(_:)),
          #selector(RichTextEditingResponder.makeLatinateLowerCase(_:)),
          #selector(RichTextEditingResponder.makeTurkicLowerCase(_:))
        ]
      #endif
      return result
    }()

    private static let actionsRequiringEditability: Set<Selector> = {
      var result: Set<Selector> = [
        #selector(TextEditingResponder.normalizeText(_:)),
        #selector(RichTextEditingResponder.makeSuperscript(_:)),
        #selector(RichTextEditingResponder.makeSubscript(_:)),
        #selector(RichTextEditingResponder.resetBaseline(_:))
      ]
      #if canImport(AppKit)
        result ∪= [
          #selector(RichTextEditingResponder.resetCasing(_:)),
          #selector(RichTextEditingResponder.makeLatinateUpperCase(_:)),
          #selector(RichTextEditingResponder.makeTurkicUpperCase(_:)),
          #selector(RichTextEditingResponder.makeLatinateSmallCaps(_:)),
          #selector(RichTextEditingResponder.makeTurkicSmallCaps(_:)),
          #selector(RichTextEditingResponder.makeLatinateLowerCase(_:)),
          #selector(RichTextEditingResponder.makeTurkicLowerCase(_:))
        ]
      #endif
      return result
    }()

    private static let actionsRequiringRichEditability: Set<Selector> = {
      var result: Set<Selector> = [
        #selector(RichTextEditingResponder.makeSuperscript(_:)),
        #selector(RichTextEditingResponder.makeSubscript(_:)),
        #selector(RichTextEditingResponder.resetBaseline(_:))
      ]
      #if canImport(AppKit)
        result ∪= [
          #selector(RichTextEditingResponder.resetCasing(_:)),
          #selector(RichTextEditingResponder.makeLatinateUpperCase(_:)),
          #selector(RichTextEditingResponder.makeTurkicUpperCase(_:)),
          #selector(RichTextEditingResponder.makeLatinateSmallCaps(_:)),
          #selector(RichTextEditingResponder.makeTurkicSmallCaps(_:)),
          #selector(RichTextEditingResponder.makeLatinateLowerCase(_:)),
          #selector(RichTextEditingResponder.makeTurkicLowerCase(_:))
        ]
      #endif
      return result
    }()

    /// Returns `nil` if the action is not recognized and should be delegated to the operating system.
    internal func canPerform(action: Selector) -> Bool? {
      if action ∈ NSUITextView.actionsRequiringSelection {
        #if canImport(AppKit)
          let selectionRange = Range<Int>(selectedRange())
        #else
          let selectionRange = selectedTextRange
        #endif
        if let selection = selectionRange {
          if ¬selection.isEmpty {
            // Next test.
          } else {
            return false  // Empty selection.
          }
        } else {
          return false  // No selection available. // @exempt(from: tests) Always empty instead.
        }
      }
      if action ∈ NSUITextView.actionsRequiringEditability {
        let isEditable: Bool
        #if os(tvOS)
          isEditable = false
        #else
          isEditable = self.isEditable
        #endif
        if ¬isEditable {
          return false  // Not editable
        }
      }
      if action ∈ NSUITextView.actionsRequiringRichEditability {
        // @exempt(from: tests) Unreachable on tvOS.
        #if canImport(AppKit)
          if isFieldEditor {
            return false  // Attributes locked.
          }
        #endif
      }
      return nil
    }

    // MARK: - RichTextEditingResponder

    @objc public func makeSuperscript(_ sender: Any?) {
      attemptToMutateSelection {
        $0.superscript(NSRange(0..<$0.length))
      }
    }

    @objc public func makeSubscript(_ sender: Any?) {
      attemptToMutateSelection {
        $0.`subscript`(NSRange(0..<$0.length))
      }
    }

    @objc public func resetBaseline(_ sender: Any?) {
      attemptToMutateSelection {
        $0.resetBaseline(for: NSRange(0..<$0.length))
      }
    }

    #if canImport(AppKit)
      @objc public func resetCasing(_ sender: Any?) {
        attemptToMutateSelection {
          $0.resetCasing(of: NSRange(0..<$0.length))
        }
      }

      @objc public func makeLatinateUpperCase(_ sender: Any?) {
        attemptToMutateSelection {
          $0.makeLatinateUpperCase(NSRange(0..<$0.length))
        }
      }
      @objc public func makeTurkicUpperCase(_ sender: Any?) {
        attemptToMutateSelection {
          $0.makeTurkicUpperCase(NSRange(0..<$0.length))
        }
      }

      @objc public func makeLatinateSmallCaps(_ sender: Any?) {
        attemptToMutateSelection {
          $0.makeLatinateSmallCaps(NSRange(0..<$0.length))
        }
      }
      @objc public func makeTurkicSmallCaps(_ sender: Any?) {
        attemptToMutateSelection {
          $0.makeTurkicSmallCaps(NSRange(0..<$0.length))
        }
      }

      @objc public func makeLatinateLowerCase(_ sender: Any?) {
        attemptToMutateSelection {
          $0.makeLatinateLowerCase(NSRange(0..<$0.length))
        }
      }
      @objc public func makeTurkicLowerCase(_ sender: Any?) {
        attemptToMutateSelection {
          $0.makeTurkicLowerCase(NSRange(0..<$0.length))
        }
      }
    #endif

    // MARK: - TextEditingResponder

    @objc public func normalizeText(_ sender: Any?) {
      attemptToModifySelection { NSAttributedString(RichText($0)) }
    }

    // MARK: - TextDisplayResponder

    @available(iOS 9, *)  // @exempt(from: unicode)
    @objc public func showCharacterInformation(_ sender: Any?) {
      let possibleString: NSAttributedString?
      #if canImport(AppKit)
        possibleString = attributedSubstring(forProposedRange: selectedRange(), actualRange: nil)
      #else
        possibleString = textStorage.attributedSubstring(from: selectedRange)
      #endif
      if let string = possibleString {
        CharacterInformation.display(
          for: string.string,
          origin: (view: AnyView(AnyCocoaView(self)), selection: selectionRectangle())
        )
      }
    }

    #if canImport(UIKit)
      // MARK: - UIResponder

      open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if let known = canPerform(action: action) {
          return known
        }
        return super.canPerformAction(action, withSender: sender)
      }
    #endif
  }
#endif
