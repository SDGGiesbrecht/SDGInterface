/*
 CocoaPopOverView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#warning("Audit.")

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #elseif canImport(UIKit)
    import UIKit
  #endif

  import SDGViews

  #if canImport(AppKit)
    internal typealias NSUIView = NSView
  #elseif canImport(UIKit)
    internal typealias NSUIView = UIView
  #endif

  internal class CocoaPopOverView: NSUIView {

    // MARK: - Initialization

    internal init<Content>(view: Content) where Content: LegacyView {
      self.view = view.cocoa()
      super.init(frame: .zero)
      CocoaView(self).fill(with: self.view, margin: nil)
    }

    internal required init?(coder decoder: NSCoder) {  // @exempt(from: tests)
      return nil
    }

    // MARK: - Properties

    private let view: CocoaView
  }
#endif
