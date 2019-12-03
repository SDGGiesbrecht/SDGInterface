/*
 SpecificView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  /// A specific type of view.
  public protocol SpecificView: View {

    #if canImport(AppKit)
      // @documentation(SpecificView.SpecificCocoaView)
      /// The specific subclass of `NSView` or `UIView`.
      associatedtype SpecificCocoaView: NSView
    #elseif canImport(UIKit)
      // #documentation(SpecificView.SpecificCocoaView)
      /// The specific native view type.
      associatedtype SpecificCocoaView: UIView
    #endif

    #if canImport(AppKit)
      // @documentation(SpecificView.specificCocoaView)
      /// The specific native view.
      var specificCocoaView: SpecificCocoaView { get }
    #elseif canImport(UIKit)
      // #documentation(SpecificView.specificCocoaView)
      /// The specific native view.
      var specificCocoaView: SpecificCocoaView { get }
    #endif
  }

  extension SpecificView {

    // MARK: - View

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return specificCocoaView
      }
    #elseif canImport(UIKit)
      public var cocoaView: UIView {
        return specificCocoaView
      }
    #endif
  }
#endif
