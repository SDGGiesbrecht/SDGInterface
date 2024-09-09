/*
 Cocoa.ViewPopOverView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if PLATFORM_HAS_COCOA_INTERFACE
  #if canImport(AppKit)
    import AppKit
  #elseif canImport(UIKit)
    import UIKit
  #endif

  extension CocoaView {

    internal class PopOverView: CocoaView.NativeType {

      // MARK: - Initialization

      internal init<Content>(_ content: Content) where Content: LegacyView {
        super.init(frame: .zero)
        CocoaView(self).fill(with: content.cocoa(), margin: nil)
      }

      internal required init?(coder decoder: NSCoder) {  // @exempt(from: tests)
        return nil
      }
    }
  }
#endif
