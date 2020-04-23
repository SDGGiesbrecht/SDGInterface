/*
 ResolvedView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  /// A view whose SwiftUI and Cocoa representations are both greedily resolved upon initialization.
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 9, *)
  internal struct Resolved<Content>: View where Content: View {

    // MARK: - Initialization

    internal init(_ content: Content) {
      self.swiftUIView = content.swiftUI()
      self.cocoaView = content.cocoa()
    }

    // MARK: - Properties

    private let swiftUIView: Content.SwiftUIView
    private let cocoaView: CocoaView

    // MARK: - LegacyView

    internal func cocoa() -> CocoaView {
      return cocoaView
    }

    // MARK: - View

    internal func swiftUI() -> some SwiftUI.View {
      return swiftUIView
    }
  }
#endif
