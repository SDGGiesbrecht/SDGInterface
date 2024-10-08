/*
 Previews.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI

  import SDGInterface

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal func previewBothModes<V>(_ view: @autoclosure () -> V, name: String) -> some SwiftUI.View
  where V: SwiftUI.View {
    return _preview(
      withAndWithout: ({ legacyMode }, { legacyMode = $0 }),
      view(),
      name: name
    )
  }
#endif
