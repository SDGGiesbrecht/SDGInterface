/*
 Window.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics
  import SDGViews

  #if canImport(AppKit)
    private let setUpFieldEditorReset: Void = {
      _resetFieldEditors = {
        for (_, window) in allWindows {  // @exempt(from: tests)
          // Only reachable with a bungled set‐up.
          window._fieldEditor = _getFieldEditor()
        }
      }
    }()
  #endif

  extension Window {

    #if canImport(AppKit)
      internal typealias Superclass = NSWindow
      internal typealias WindowDelegate = AppKit.NSWindowDelegate
    #else
      internal typealias Superclass = UIWindow
      internal typealias WindowDelegate = UIWindowDelegate
    #endif

    internal class CocoaImplementation<Content>: Superclass, SharedValueObserver, WindowDelegate
    where Content: LegacyView {

      // MARK: - Initialization

      internal init(name: UserFacing<StrictString, L>, view: Content) {
        #if canImport(AppKit)
          setUpFieldEditorReset
        #endif

        defer {
          #warning("Rethink.")
          CocoaWindow(self).randomizeLocation()
        }

        self.name = name
        defer {
          LocalizationSetting.current.register(observer: self)
        }

        self.view = view.cocoa()
        defer {
          #if canImport(AppKit)
            contentView = self.view.native
          #elseif canImport(UIKit)
            if rootViewController == nil {
              rootViewController = UIViewController()
            }
            rootViewController?.view.map { rootView in
              CocoaView(rootView).fill(with: self.view, margin: 0)
            }
          #endif
        }

        #if canImport(AppKit)
          super.init(
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
          super.init(frame: CGRect.zero)
        #endif

        #if canImport(AppKit)
          defer {
            delegate = self
          }
        #endif

        #if canImport(AppKit)
          isReleasedWhenClosed = false
        #endif

        #if canImport(AppKit)
          titleVisibility = .hidden
          setAutorecalculatesContentBorderThickness(false, for: NSRectEdge.minY)
          setContentBorderThickness(0, for: NSRectEdge.minY)
        #endif
      }

      #if canImport(UIKit)
        required init?(coder: NSCoder) {  // @exempt(from: tests)
          return nil
        }
      #endif

      // MARK: - Properties

      private let name: UserFacing<StrictString, L>
      private let view: CocoaView

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        #warning("Not implemented yet.")
      }
    }
  }
#endif
