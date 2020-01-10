/*
 Colour.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI
#endif
#if canImport(AppKit)
  import AppKit
#elseif canImport(UIKit)
  import UIKit
#endif

import SDGInterfaceBasics

extension Colour: View {

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    @available(macOS 10.15, iOS 13, tvOS 13, *)
    public var swiftUIView: AnyView {
      return AnyView(SwiftUI.Color(self))
    }
  #endif

  #if canImport(AppKit)
      public var cocoaView: NSView {

      }
  #else
      public var cocoaView: UIView {

      }
  #endif
}
