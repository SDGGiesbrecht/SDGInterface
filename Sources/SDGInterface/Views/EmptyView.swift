/*
 EmptyView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI
#endif
#if canImport(AppKit)
  import AppKit
#elseif canImport(UIKit)
  import UIKit
#endif

/// A shimmed version of `SwiftUI.EmptyView` with no availability constraints.
public struct EmptyView: View {

  // MARK: - Initialization

  /// A shimmed version of `SwiftUI.EmptyView.init()` with no availability constraints.
  public init() {}

  // MARK: - View

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
    public func swiftUI() -> some SwiftUI.View {
      return SwiftUI.EmptyView()
    }
  #endif

  #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
    public func cocoa() -> CocoaView {
      return CocoaView(CocoaView.NativeType())
    }
  #endif
}
