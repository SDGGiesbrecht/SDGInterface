/*
 CocoaExample.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  #if canImport(AppKit)
    class CocoaExample: NSView {}
  #else
    class CocoaExample: UIView {}
  #endif
  extension CocoaExample: CocoaViewImplementation {}
#endif
