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
  extension Window {

    @available(macOS 11, tvOS 14, *)
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

      internal var body: some Scene {

        let minWidth: CGFloat?
        let minHeight: CGFloat?

        #if canImport(AppKit)
          switch type {
          case .primary(let size),
            .auxiliary(let size):
            minWidth = size.map { CGFloat($0.width) }
            minHeight = size.map { CGFloat($0.height) }
          case .fullscreen:
            minWidth = nil
            minHeight = nil
          }
        #else
          switch type {
          case .primary(let size):
            minWidth = size.map { CGFloat($0.width) }
            minHeight = size.map { CGFloat($0.height) }
          }
        #endif

        return WindowGroup(String(name.resolved())) {
          content
            .background(
              SwiftUIImplementation.WindowFinder(onFound: { found in
                #if canImport(AppKit)
                  found?.native.delegate = self.delegate
                #endif
                #if canImport(AppKit)
                  switch type {
                  case .primary:
                    found?.isPrimary = true
                  case .auxiliary:
                    found?.isAuxiliary = true
                  case .fullscreen:
                    found?.isFullscreen = true
                  }
                #endif
              })
            )
            .frame(minWidth: minWidth, minHeight: minHeight)
        }
      }
    }
  }
#endif
