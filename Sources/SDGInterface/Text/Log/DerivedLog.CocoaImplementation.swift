/*
 DerivedLog.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if PLATFORM_HAS_COCOA_INTERFACE
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow
  import SDGLogic

  extension DerivedLog {

    internal class CocoaImplementation: TextEditor.CocoaFrameView, SharedValueObserver {

      // MARK: - Initialization

      internal init(
        source: Shared<Source>,
        derivation: @escaping (Source) -> RichText,
        transparentBackground: Bool,
        logMode: Bool
      ) {
        self.source = source
        defer { source.register(observer: self) }

        self.derivation = derivation

        super.init(
          transparentBackground: transparentBackground,
          logMode: logMode
        )
      }

      internal required init?(coder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let source: Shared<Source>
      private let derivation: (Source) -> RichText

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        let derived = derivation(source.value)
        let newValue = derived.attributedString()
        let existingValue: NSAttributedString
        #if canImport(AppKit)
          existingValue = textView.attributedString()
        #else
          existingValue =
            textView.attributedText
            ?? NSAttributedString()  // @exempt(from: tests) Never nil.
        #endif
        if existingValue ≠ newValue {
          updateContents(to: derived)
        }
      }
    }
  }
#endif
