/*
 Image.Definition.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  extension Image {

    internal enum Definition {

      #if canImport(AppKit) || canImport(UIKit)
        case cocoa(CocoaImage)
      #endif

      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        /// The associated value is a `Swift.Image` where available, or `nil`.
        case swiftUI(Any?)
      #endif
    }
  }
#endif
