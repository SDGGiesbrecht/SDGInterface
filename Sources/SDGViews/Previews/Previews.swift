/*
 Previews.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  internal func previewBothModes<V>(_ view: @autoclosure () -> V, name: String) -> some SwiftUI.View
  where V: SwiftUI.View {

    func preview(_ view: () -> V, legacyMode: Bool) -> some SwiftUI.View {
      let previous = SDGViews.legacyMode
      SDGViews.legacyMode = legacyMode
      defer { SDGViews.legacyMode = previous }
      return view()
        .padding(1)
        .border(Color.gray, width: 1)
    }

    let stack = HStack(spacing: 8) {
      preview(view, legacyMode: false)
      preview(view, legacyMode: true)
    }
    return
      stack
      .previewDisplayName(name)
  }
#endif
