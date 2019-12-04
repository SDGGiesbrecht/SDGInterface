/*
 MarginView.swift

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

  /// A view providing a margin around another view.
  public final class MarginView: View {

    // MARK: - Initialization

    /// Creates a margin view.
    ///
    /// - Parameters:
    ///     - contents: The content view.
    public init(contents: View) {
      self.contents = contents
      AnyCocoaView(cocoaView).fill(with: contents)
    }

    // MARK: - Properties

    /// The content view.
    public let contents: View

    #if canImport(AppKit)
      public let cocoaView: NSView = NSView()
    #elseif canImport(UIKit)
      public let cocoaView: UIView = UIView()
    #endif
  }
#endif
