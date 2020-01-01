/*
 AnyRadioButtonSet.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #elseif canImport(UIKit)
    import UIKit
  #endif

  import SDGViews

  /// A set of radio buttons with no particular localization.
  public protocol AnyRadioButtonSet: AnyObject, CocoaViewImplementation {
    #if canImport(AppKit)
      // #documentation(SpecificView.specificCocoaView)
      /// The specific subclass of `NSView` or `UIView`.
      var specificCocoaView: NSSegmentedControl { get }
    #elseif canImport(UIKit)
      // #documentation(SpecificView.specificCocoaView)
      /// The specific subclass of `NSView` or `UIView`.
      var specificCocoaView: UISegmentedControl { get }
    #endif
    func _refreshBindings()
  }

  extension AnyRadioButtonSet {

    internal func refreshBindings() {
      _refreshBindings()
    }
  }
#endif
