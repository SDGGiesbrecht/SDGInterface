/*
 Window.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGText
  import SDGLocalization

  import SDGViews

  extension Window {

    #if canImport(AppKit)
      internal typealias Superclass = NSWindow
    #else
      internal typealias Superclass = UIWindow
    #endif

    internal class CocoaImplementation<Content>: Superclass where Content: LegacyView {

      // MARK: - Initialization

      internal init(name: UserFacing<StrictString, L>, view: Content) {
        #warning("Not implemented yet.")
        super.init(frame: .zero)
      }

      required init?(coder: NSCoder) {  // @exempt(from: tests)
        return nil
      }
    }
  }
#endif
