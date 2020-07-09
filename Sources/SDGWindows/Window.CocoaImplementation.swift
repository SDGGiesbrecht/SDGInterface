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
          if let managed = window as? ManagedWindow {
            // Only reachable with a bungled set‐up.
            managed.fieldEditor = _getFieldEditor()
          }
        }
      }
    }()
  #endif

  extension Window {

    #if canImport(AppKit)
      internal typealias Superclass = NSWindow
      internal typealias WindowDelegate = NSWindowDelegate
    #else
      internal typealias Superclass = UIWindow
      internal typealias WindowDelegate = UIWindowDelegate
    #endif

    internal class CocoaImplementation<Content>: Superclass, ManagedWindow, SharedValueObserver,
      WindowDelegate
    where Content: LegacyView {

      // MARK: - Initialization

      internal init(
        name: UserFacing<StrictString, L>,
        content: Content,
        onClose: @escaping () -> Void
      ) {
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

        self.content = content.cocoa()
        defer {
          #if canImport(AppKit)
            contentView = self.content.native
          #elseif canImport(UIKit)
            if rootViewController == nil {
              rootViewController = UIViewController()
            }
            rootViewController?.view.map { rootView in
              CocoaView(rootView).fill(with: self.content, margin: 0)
            }
          #endif
        }

        self.onClose = onClose

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
      private let content: CocoaView
      internal let onClose: () -> Void
      public var fieldEditor = _getFieldEditor()

      // MARK: - NSWindowDelegate

      internal func windowWillReturnFieldEditor(_ sender: NSWindow, to client: Any?) -> Any? {
        return fieldEditor
      }

      internal func windowWillClose(_ notification: Notification) {
        finishClosing()
      }

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        #if canImport(AppKit)
          title = String(name.resolved())
        #elseif DEBUG  // For test coverage.
          _ = name.resolved()
        #endif
      }
    }
  }
#endif
