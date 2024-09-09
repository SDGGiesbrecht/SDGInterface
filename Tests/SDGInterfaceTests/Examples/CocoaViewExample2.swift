/*
 CocoaViewExample2.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(AppKit)
    import AppKit
  #else
    import UIKit
  #endif

  import SDGInterface

  struct CocoaViewExample2: LegacyView {

    func cocoa() -> CocoaView {
      return CocoaView()
    }
  }

  extension CocoaViewExample2: View, ViewShims {}
  extension CocoaViewExample2: CocoaViewImplementation {}
#endif
