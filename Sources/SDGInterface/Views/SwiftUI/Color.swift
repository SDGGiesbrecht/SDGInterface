/*
 Color.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

#if canImport(SwiftUI)

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension SwiftUI.Color: SwiftUIViewImplementation {

    /// The colour as a `SwiftUI.Color` instance.
    ///
    /// - Parameters:
    ///   - colour: The colour.
    public init(_ colour: SDGInterface.Colour) {
      self.init(red: colour.red, green: colour.green, blue: colour.blue, opacity: colour.opacity)
    }
  }

#endif
