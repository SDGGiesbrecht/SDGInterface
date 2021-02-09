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

    @available(macOS 11, *)
    internal struct SwiftUIImplementation<ContentView>: Scene where ContentView: SwiftUI.View {

      // MARK: - Initialization

      #warning("Why @escaping for content?")
      internal init(
        type: WindowType,
        name: UserFacing<StrictString, L>,
        content: @escaping () -> ContentView,
        onClose: @escaping () -> Void
      ) {
        self.type = type
        self.name = name
        self.content = content
        self.delegate = Delegate(onClose: onClose)
      }

      // MARK: - Properties

      internal let type: WindowType
      internal let name: UserFacing<StrictString, L>
      internal let content: () -> ContentView
      internal let delegate: Delegate

      // MARK: - Scene

      internal var body: some Scene {
        let view = content()
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
        #warning("Remove AnyView?")
        let anyView: SwiftUI.AnyView
        switch type {
        case .primary(let size),
          .auxiliary(let size):
          if let size = size {
            anyView = SwiftUI.AnyView(
              view.frame(minWidth: CGFloat(size.width), minHeight: CGFloat(size.height))
            )
          } else {
            anyView = SwiftUI.AnyView(view)
          }
        case .fullscreen:
          anyView = SwiftUI.AnyView(view)
        }
        return WindowGroup(String(name.resolved())) {
          anyView
        }
      }
    }
  }
#endif
