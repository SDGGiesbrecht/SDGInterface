/*
 Window.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif
#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

import SDGText
import SDGLocalization

/// A window.
@available(watchOS 6, *)
public struct Window<Content, L>: LegacyWindow where Content: LegacyView, L: Localization {

  // MARK: - Initialization

  /// Creates a window.
  ///
  /// - Parameters:
  ///   - type: The type of window.
  ///   - name: The name of the window. (Used in places like the title bar or dock.)
  ///   - content: The content view.
  ///   - onClose: A closure to execute when the window closes.
  public init(
    type: WindowType,
    name: UserFacing<StrictString, L>,
    content: Content,
    onClose: @escaping () -> Void = {}
  ) {
    self.type = type
    self.name = name
    self.content = content
    self.onClose = onClose
  }

  // MARK: - Properties

  private let type: WindowType
  private let name: UserFacing<StrictString, L>
  private let content: Content
  private let onClose: () -> Void

  // MARK: - WindowProtocol

  #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
    public func cocoa() -> CocoaWindow {
      return CocoaWindow(
        CocoaImplementation(type: type, name: name, content: content, onClose: onClose)
      )
    }
  #endif
}

@available(macOS 11, tvOS 14, iOS 14, watchOS 7, *)
extension Window: WindowProtocol where Content: SDGInterface.View {

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    public func swiftUI() -> some Scene {
      return SwiftUIImplementation(
        type: type,
        name: name,
        content: content.swiftUI(),
        onClose: onClose
      )
    }
  #endif
}
