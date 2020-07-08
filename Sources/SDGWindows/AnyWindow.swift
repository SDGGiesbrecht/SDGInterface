/*
 AnyWindow.swift

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

  import SDGMathematics
  import SDGGeometry

  import SDGViews

  import SDGInterfaceBasics

  internal var allWindows = [ObjectIdentifier: AnyWindow]()

  /// A menu entry with no particular localization.
  public protocol AnyWindow: AnyObject {

    /// The root view.
    var view: CocoaView { get set }

    #if canImport(AppKit)
      /// The Cocoa window.
      var cocoa: NSWindow { get }
    #elseif canImport(UIKit)
      /// The Cocoa window.
      var cocoa: UIWindow { get }
    #endif

    /// An action performed when the window closes.
    var closeAction: () -> Void { get set }

    #if canImport(AppKit)
      var _fieldEditor: NSTextView { get set }
    #endif

    func _refreshBindings()
  }

  extension AnyWindow {

    internal func refreshBindings() {
      _refreshBindings()
    }

    // MARK: - Static Properties

    /// A size that fills the available space on the main screen, without obscuring menu bars, docks, etc.
    public static var availableSize: Size {
      #if canImport(AppKit)
        return Size(
          (NSScreen.main
            ?? NSScreen()  // @exempt(from: tests) Screen should not be nil.
            ).frame.size
        )
      #elseif canImport(UIKit)
        return Size(UIScreen.main.bounds.size)
      #endif
    }

    #if canImport(AppKit)
      /// The default size of an auxiliary window.
      public static var auxiliarySize: Size {
        return Size(width: 480, height: 270)
      }
    #endif

    // MARK: - Display

    /// Displays the window.
    public func display() {
      allWindows[ObjectIdentifier(self)] = self
      #if canImport(AppKit)
        cocoa.makeKeyAndOrderFront(nil)
      #elseif canImport(UIKit)
        cocoa.makeKeyAndVisible()
      #endif
    }

    /// Whether or not the window is visible.
    ///
    /// The window may still be obscured by other elements on the screen.
    public var isVisible: Bool {
      #if canImport(AppKit)
        return cocoa.isVisible
      #elseif canImport(UIKit)
        return cocoa.isHidden
      #endif
    }

    internal func finishClosing() {
      // Release
      allWindows[ObjectIdentifier(self)] = nil

      closeAction()
    }

    /// Closes the window.
    public func close() {
      #if canImport(AppKit)
        cocoa.close()
      #else
        finishClosing()
      #endif
    }

    // MARK: - Size & Location

    /// The size of the window.
    ///
    /// Changing this value when the window is visible results in a smooth animation.
    public var size: Size {
      get {
        return Size(frame.size)
      }
      set {
        frame.size = CGSize(newValue)
      }
    }

    /// The location of the window’s origin.
    ///
    /// Changing this value when the window is visible results in a smooth animation.
    public var location: Point {
      get {
        return Point(frame.origin)
      }
      set {
        frame.origin = CGPoint(newValue)
      }
    }

    private var frame: CGRect {
      get {
        return cocoa.frame
      }
      set {
        #if canImport(AppKit)
          if cocoa.isVisible {
            cocoa.setFrame(newValue, display: true, animate: true)
          } else {
            cocoa.setFrame(newValue, display: true, animate: false)
          }
        #elseif canImport(UIKit)
          cocoa.frame = newValue
        #endif
      }
    }

    private var nearestScreenFrame: CGRect {
      #if canImport(AppKit)
        let screen: NSScreen
        if let theScreen = cocoa.screen {  // @exempt(from: tests) Not on screen during tests.
          screen = theScreen
        } else if let theScreen = NSScreen.main {
          screen = theScreen
        } else {  // @exempt(from: tests)
          screen = NSScreen()
        }
        return screen.frame
      #elseif canImport(UIKit)
        return cocoa.screen.bounds
      #endif
    }

    /// Moves the window smoothly to the centre of the screen.
    public func centreInScreen() {
      var windowFrame = frame
      let screenFrame = nearestScreenFrame

      windowFrame.origin.x = ((screenFrame.size.width − windowFrame.size.width) ÷ 2)
      windowFrame.origin.y = ((screenFrame.size.height − windowFrame.size.height) × 2 ÷ 3)

      frame = windowFrame
    }

    /// Moves the window smoothly to a random location on the screen.
    public func randomizeLocation() {
      var windowFrame = frame
      let screenFrame = nearestScreenFrame

      var rangeX = screenFrame.size.width − windowFrame.size.width
      rangeX.increase(to: 0)
      var rangeY = screenFrame.size.height − windowFrame.size.height
      rangeY.increase(to: 0)

      windowFrame.origin.x = CGFloat.random(in: 0...rangeX)
      windowFrame.origin.y = CGFloat.random(in: 0...rangeY)

      frame = windowFrame
    }

    // MARK: - Fullscreen

    #if canImport(AppKit)
      /// Returns whether or not the window is in fullscreen mode.
      ///
      /// For a smoother transition, the effect of setting this property may be delayed until the window is ready to switch.
      public var isFullscreen: Bool {
        get {
          return cocoa.styleMask.contains(.fullScreen)
        }
        set {
          let observer = FullscreenObserver(window: self)
          observer.setFullscreenModeSettingAsSoonAsPossible(newValue)
        }
      }

      /// Whether the window is considered a primary window or not.
      ///
      /// Primary windows can be the main window of fullscreen mode.
      public var isPrimary: Bool {
        get {
          return cocoa.collectionBehavior.contains(.fullScreenPrimary)
        }
        set {
          if newValue {
            cocoa.collectionBehavior.insert(.fullScreenPrimary)
          } else {
            cocoa.collectionBehavior.remove(.fullScreenPrimary)
          }
        }
      }

      /// Whether the window is considered an auxiliary window or not.
      ///
      /// Auxiliary windows can appear on top of another fullscreen window.
      public var isAuxiliary: Bool {
        get {
          return cocoa.collectionBehavior.contains(.fullScreenAuxiliary)
        }
        set {
          if newValue {
            cocoa.collectionBehavior.insert(.fullScreenAuxiliary)
          } else {
            cocoa.collectionBehavior.remove(.fullScreenAuxiliary)
          }
        }
      }
    #endif
  }
#endif
