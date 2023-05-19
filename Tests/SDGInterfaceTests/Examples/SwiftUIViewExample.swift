/*
 SwiftUIViewExample.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI

  import SDGInterface

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  struct SwiftUIViewExample: SwiftUI.View, SwiftUIViewImplementation {

    // MARK: - View

    var body: some SwiftUI.View {
      return Text(verbatim: "...")
    }
  }
#endif
