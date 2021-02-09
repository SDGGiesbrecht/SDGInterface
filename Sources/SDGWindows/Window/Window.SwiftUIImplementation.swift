/*
 Window.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGControlFlow
import SDGText
import SDGLocalization

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(watchOS 7, *)
  extension Window {

    @available(macOS 11, tvOS 14, iOS 14, *)
    internal struct SwiftUIImplementation<ContentView>: Scene where ContentView: SwiftUI.View {

      // MARK: - Initialization

      internal init(
        type: WindowType,
        name: UserFacing<StrictString, L>,
        content: ContentView,
        onClose: @escaping () -> Void
      ) {
        self.type = type
        self.name = name
        self.content = content
        #if canImport(AppKit)
          self.delegate = Delegate(onClose: onClose)
        #endif
      }

      // MARK: - Properties

      internal let type: WindowType
      internal let name: UserFacing<StrictString, L>
      internal let content: ContentView
      #if canImport(AppKit)
        internal let delegate: Delegate
      #endif

      // MARK: - Scene

      private func minimums() -> (width: CGFloat?, height: CGFloat?) {
        let minimumWidth: CGFloat?
        let minimumHeight: CGFloat?

        #if canImport(AppKit)
          switch type {
          case .primary(let size),
            .auxiliary(let size):
            minimumWidth = size.map { CGFloat($0.width) }
            minimumHeight = size.map { CGFloat($0.height) }
          case .fullscreen:
            minimumWidth = nil
            minimumHeight = nil
          }
        #else
          switch type {
          case .primary(let size):
            minimumWidth = size.map { CGFloat($0.width) }
            minimumHeight = size.map { CGFloat($0.height) }
          }
        #endif

        return (minimumWidth, minimumHeight)
      }

      private func intermediate() -> some SwiftUI.View {
        #if canImport(AppKit)
          return
            content
            .background(
              SwiftUIImplementation.WindowFinder(onFound: { found in
                found?.native.delegate = self.delegate
                switch type {
                case .primary:
                  found?.isPrimary = true
                case .auxiliary:
                  found?.isAuxiliary = true
                case .fullscreen:
                  found?.isFullscreen = true
                }
              })
            )
        #else
          return content
        #endif
      }

      internal var body: some Scene {
        let minimums = self.minimums()
        return WindowGroup(String(name.resolved())) {
          return intermediate().frame(minWidth: minimums.width, minHeight: minimums.height)
        }
      }
    }
  }
#endif
