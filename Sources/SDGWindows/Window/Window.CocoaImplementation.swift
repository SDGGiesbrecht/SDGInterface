/*
 Window.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGInterface
  import SDGViews

  extension Window {

    #if canImport(AppKit)
      internal typealias Superclass = NSWindow
      internal typealias WindowDelegate = NSWindowDelegate
    #else
      internal typealias Superclass = UIWindow
      internal typealias WindowDelegate = Placeholder
    #endif

    internal class CocoaImplementation<Content>: Superclass, ManagedWindow, SharedValueObserver,
      WindowDelegate
    where Content: LegacyView {

      // MARK: - Initialization

      internal init(
        type: WindowType,
        name: UserFacing<StrictString, L>,
        content: Content,
        onClose: @escaping () -> Void
      ) {
        defer {
          switch type {
          case .primary:
            #if canImport(AppKit)
              CocoaWindow(self).isPrimary = true
            #else
              break
            #endif
          #if canImport(AppKit)
            case .auxiliary:
              CocoaWindow(self).isAuxiliary = true
            case .fullscreen:
              CocoaWindow(self).isPrimary = true
              CocoaWindow(self).isFullscreen = true
          #endif
          }
        }

        defer {
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

        let resolvedSize: Size
        switch type {
        case .primary(let size):
          resolvedSize = size ?? Size.fillingAvailable()
        #if canImport(AppKit)
          case .auxiliary(let size):
            resolvedSize = size ?? Size.auxiliaryWindow
          case .fullscreen:
            resolvedSize = Size.fillingAvailable()
        #endif
        }
        let frame = CGRect(origin: .zero, size: CGSize(resolvedSize))

        #if canImport(AppKit)
          super.init(
            contentRect: frame,
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
          super.init(frame: frame)
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
        internal required init?(coder: NSCoder) {  // @exempt(from: tests)
          return nil
        }
      #endif

      // MARK: - Properties

      private let name: UserFacing<StrictString, L>
      private let content: CocoaView
      internal let onClose: () -> Void

      #if canImport(AppKit)
        // MARK: - NSWindowDelegate

        internal func windowWillClose(_ notification: Notification) {
          finishClosing()
        }
      #endif

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
