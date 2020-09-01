/*
 TextField.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI

  import SDGControlFlow
  import SDGText

  extension TextField {

    @available(macOS 10.15, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      @ObservedObject internal var contents: Shared<StrictString>

      // MARK: - View

      internal var body: some SwiftUI.View {
        return SwiftUI.TextField("", text: $contents.value.compatibility)
      }
    }
  }
#endif
