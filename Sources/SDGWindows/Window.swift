/*
 Window.swift

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

  #warning("Audit these.")
  import SDGLogic
  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics
  import SDGViews

  /// A window.
  public final class Window<Content, L>: WindowProtocol where L: Localization {

    // MARK: - Generators

    /// Creates a primary window.
    ///
    /// - Parameters:
    ///     - name: The name of the window. (Used in places like the title bar or dock.)
    ///     - view: The view.
    public static func primaryWindow(name: Binding<StrictString, L>, view: CocoaView) -> Window {
      let window = Window(name: name, view: view)
      window.size = availableSize
      #if canImport(UIKit)
        window.cocoa.frame.origin = CGPoint(x: 0, y: 0)
      #endif
      #if canImport(AppKit)
        window.isPrimary = true
      #endif
      return window
    }

    #if canImport(AppKit)
      /// Creates an auxiliary window.
      ///
      /// - Parameters:
      ///     - name: The name of the window. (Used in places like the title bar or dock.)
      ///     - view: The view.
      public static func auxiliaryWindow(name: Binding<StrictString, L>, view: CocoaView) -> Window
      {
        let window = Window(name: name, view: view)
        window.size = auxiliarySize
        window.isAuxiliary = true
        return window
      }

      /// Creates a fullscreen window.
      ///
      /// - Parameters:
      ///     - name: The name of the window. (Used in places like the title bar or dock.)
      ///     - view: The view.
      public static func fullscreenWindow(name: Binding<StrictString, L>, view: CocoaView) -> Window
      {
        let window = primaryWindow(name: name, view: view)
        window.isFullscreen = true
        return window
      }
    #endif

    // MARK: - Initialization

    /// Creates a window.
    ///
    /// - Parameters:
    ///     - name: The name of the window. (Used in places like the title bar or dock.)
    ///     - content: The content view.
    ///     - onClose: A closure to execute when the window closes.
    public init(
      name: UserFacing<StrictString, L>,
      content: Content,
      onClose: () -> Void = {}
    ) {
      self.name = name
      self.content = content
    }

    // MARK: - Properties

    private let name: UserFacing<StrictString, L>
    private let content: Content
    private let onClose: () -> Void

    // MARK: - Display

    /// Displays the window.
    public func display() {
      cocoa().display()
    }
  }
#endif
