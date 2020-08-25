/*
 AnyLabel.swift

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

  import SDGInterfaceBasics
  import SDGViews

  /// A label with no particular localization.
  public protocol AnyLabel: AnyObject, LegacyView {
    #if canImport(AppKit)
      /// The specific subclass of `NSView` or `UIView`.
      var specificCocoaView: NSTextField { get }
    #elseif canImport(UIKit)
      /// The specific subclass of `NSView` or `UIView`.
      var specificCocoaView: UILabel { get }
    #endif
    func _refreshBindings()
  }

  extension AnyLabel {

    internal func refreshBindings() {
      _refreshBindings()
    }

    // MARK: - Properties

    /// The colour of the text.
    public var textColour: Colour? {
      get {
        return specificCocoaView.textColor.flatMap { Colour($0) }
      }
      set {
        #if canImport(AppKit)
          specificCocoaView.textColor = newValue.map({ NSColor($0) })
        #elseif canImport(UIKit)
          specificCocoaView.textColor = newValue.map({ UIColor($0) })
        #endif
      }
    }
  }
#endif
