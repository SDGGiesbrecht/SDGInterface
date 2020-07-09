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

  import SDGLogic
  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics
  import SDGViews

  /// A window.
  public final class Window<L>: AnyWindow where L: Localization {

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
    ///     - view: The view.
    public init(name: Binding<StrictString, L>, view: CocoaView) {
      #if canImport(AppKit)
        setUpFieldEditorReset
      #endif

      defer {
        randomizeLocation()
      }

      self.name = name
      defer {
        nameDidSet()
        LocalizationSetting.current.register(observer: bindingObserver)
      }

      self.view = view
      defer {
        viewDidSet()
      }

      #if canImport(AppKit)
        cocoa = NSWindow(
          contentRect: NSRect.zero,
          styleMask: [
            .titled,
            .closable,
            .miniaturizable,
            .resizable,
            .texturedBackground,
            .unifiedTitleAndToolbar,
          ],
          backing: .buffered,
          defer: true
        )
      #elseif canImport(UIKit)
        cocoa = UIWindow(frame: CGRect.zero)
      #endif

      defer {
        bindingObserver.window = self
      }

      #if canImport(AppKit)
        defer {
          cocoa.delegate = delegate
          delegate.window = self
        }
      #endif

      #if canImport(AppKit)
        cocoa.isReleasedWhenClosed = false
      #endif

      #if canImport(AppKit)
        cocoa.titleVisibility = .hidden
        cocoa.setAutorecalculatesContentBorderThickness(false, for: NSRectEdge.minY)
        cocoa.setContentBorderThickness(0, for: NSRectEdge.minY)
      #endif
    }

    // MARK: - Properties

    private let bindingObserver = BindingObserver()

    /// The name of the window.
    ///
    /// The name is used in places like the title bar and dock.
    public var name: Binding<StrictString, L>

    /// The root view.
    public var view: CocoaView

    #if canImport(AppKit)
      /// The Cocoa window.
      public let cocoa: NSWindow
      private let delegate = NSWindowDelegate()
      public var _fieldEditor = _getFieldEditor()
    #elseif canImport(UIKit)
      /// The Cocoa window.
      public let cocoa: UIWindow
    #endif

    // MARK: - Refreshing

    public func _refreshBindings() {
      #if canImport(AppKit)
        cocoa.title = String(name.resolved())
      #elseif DEBUG  // For test coverage.
        _ = name.resolved()
      #endif
    }

    // MARK: - AnyWindow

    public var closeAction: () -> Void = {}
  }
#endif
