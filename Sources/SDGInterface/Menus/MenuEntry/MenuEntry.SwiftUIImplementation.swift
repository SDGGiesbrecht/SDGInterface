/*
 MenuEntry.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  @available(tvOS 14, watchOS 6, *)
  extension MenuEntry {

    @available(macOS 11, iOS 14, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let label: UserFacing<StrictString, L>
      internal let action: () -> Void
      internal let hotKeyModifiers: EventModifiers
      internal let hotKey: Character?
      internal let isDisabled: () -> Bool
      @ObservedObject internal var isHidden: Shared<Bool>

      // MARK: - View

      private var partialBody1: some SwiftUI.View {
        return Button(
          label: label,
          action: action
        ).swiftUI()
      }
      @ViewBuilder private var partialBody2: some SwiftUI.View {
        #if os(tvOS) || os(watchOS)
          partialBody1
        #else
          if let hotKey = hotKey {
            partialBody1.keyboardShortcut(KeyEquivalent(hotKey), modifiers: hotKeyModifiers)
          } else {
            partialBody1
          }
        #endif
      }
      private var partialBody3: some SwiftUI.View {
        return
          partialBody2
          .disabled(isDisabled())
      }
      @ViewBuilder internal var body: some SwiftUI.View {
        if isHidden.value {
          SwiftUI.EmptyView()
        } else {
          partialBody3
        }
      }
    }
  }
#endif
