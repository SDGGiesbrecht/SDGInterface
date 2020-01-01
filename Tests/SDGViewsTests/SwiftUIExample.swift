/*
 SwiftUIExample.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGViews

  @available(macOS 10.15, iOS 13, tvOS 13, *)
  struct SwiftUIExample: SwiftUI.View, SwiftUIViewImplementation {

    // MARK: - View

    var body: some SwiftUI.View {
      return Text(verbatim: "...")
    }
  }
#endif
