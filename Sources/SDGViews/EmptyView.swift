/*
 EmptyView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  /// A shimmed version of `SwiftUI.EmptyView` with no availability constraints.
  @available(watchOS 9, *)
  public struct EmptyView: View {

    // MARK: - Initialization

    /// A shimmed version of `SwiftUI.EmptyView.init()` with no availability constraints.
    public init() {}

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      @available(macOS 10.15, tvOS 13, iOS 13, *)
      public var swiftUIView: AnyView {
        return AnyView(SwiftUI.EmptyView())
      }
    #endif

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return NSView()
      }
    #elseif canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        return UIView()
      }
    #endif
  }
#endif
