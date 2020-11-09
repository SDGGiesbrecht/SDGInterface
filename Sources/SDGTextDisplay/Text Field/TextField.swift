/*
 TextField.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow
  import SDGText

  import SDGViews

  /// A text label.
  @available(watchOS 6, *)
  public struct TextField: LegacyView {

    // MARK: - Initialization

    /// Creates a text field.
    ///
    /// - Parameters:
    ///   - contents: A binding to the contents of the text field.
    public init(
      contents: Shared<StrictString>,
      onCommit: @escaping () -> Void = {}
    ) {
      self.contents = contents
      self.onCommit = onCommit
    }

    // MARK: - Properties

    private let contents: Shared<StrictString>
    private let onCommit: () -> Void

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        // #workaround(Swift 5.2.4, Would be a step backward on other platforms without the ability to interact properly with menus.)
        #if os(watchOS)
          return useSwiftUIOrFallback(to: {
            return CocoaView(
              CocoaImplementation(contents: contents, onCommit: onCommit)
            )
          })
        #else
          return CocoaView(CocoaImplementation(contents: contents, onCommit: onCommit))
        #endif
      }
    #endif
  }

  // #workaround(Swift 5.2.4, Would be a step backward on other platforms without the ability to interact properly with menus.)
  #if os(watchOS)
    @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
    extension TextField: View {

      // MARK: - View

      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        public func swiftUI() -> some SwiftUI.View {
          return SwiftUIImplementation(contents: contents, onCommit: onCommit)
        }
      #endif
    }
  #else
    extension TextField: CocoaViewImplementation {}
  #endif
#endif
