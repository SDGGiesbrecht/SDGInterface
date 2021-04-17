#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
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
