/*
 CocoaPopOverView.swift

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

  internal class CocoaPopOverView: CocoaView.NativeType {

    // MARK: - Initialization

    internal init<Content>(view: Content) where Content: LegacyView {
      super.init(frame: .zero)
      CocoaView(self).fill(with: view.cocoa(), margin: nil)
    }

    internal required init?(coder decoder: NSCoder) {  // @exempt(from: tests)
      return nil
    }
  }
#endif
