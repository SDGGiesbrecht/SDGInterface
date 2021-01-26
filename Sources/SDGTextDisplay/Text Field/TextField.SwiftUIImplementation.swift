/*
 TextField.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.2, SwiftUI would be a step backward from AppKit or UIKit without the ability to get the selected text for menu items like “Show Character Information”.)
#if canImport(SwiftUI) && !canImport(AppKit) && !(canImport(UIKit) && !os(watchOS))
  import SwiftUI

  import SDGControlFlow
  import SDGText

  @available(watchOS 6, *)
  extension TextField {

    @available(macOS 10.15, tvOS 13, iOS 13, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      @ObservedObject internal var contents: Shared<StrictString>
      internal let onCommit: () -> Void

      // MARK: - View

      internal var body: some SwiftUI.View {
        return SwiftUI.TextField(
          "",
          text: $contents.value.compatibility,
          onCommit: onCommit
        )
      }
    }
  }
#endif
