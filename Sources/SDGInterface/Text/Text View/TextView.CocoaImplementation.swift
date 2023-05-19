/*
 TextView.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
  import SDGLocalization

  extension TextView {

    internal class CocoaImplementation: TextEditor.CocoaFrameView, SharedValueObserver {

      // MARK: - Initialization

      internal init(
        contents: UserFacing<RichText, L>,
        transparentBackground: Bool
      ) {
        self.contents = contents
        defer { LocalizationSetting.current.register(observer: self) }

        super.init(transparentBackground: transparentBackground, logMode: false)
        #if !os(tvOS)
          setEditability(false)
        #endif
      }

      internal required init?(coder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let contents: UserFacing<RichText, L>

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        updateContents(to: contents.resolved())
      }
    }
  }
#endif
