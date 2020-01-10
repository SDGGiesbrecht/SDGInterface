/*
 Color.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI
#endif

import SDGInterfaceBasics

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))

  @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
  extension SwiftUI.Color: SwiftUIViewImplementation {

    /// The colour as a `SwiftUI.Color` instance.
    public init(_ colour: SDGInterfaceBasics.Colour) {
      return SwiftUI.Color(red: colour.red, green: colour.green, blue: colour.blue, opacity: colour.opacity)
    }
  }

#endif
