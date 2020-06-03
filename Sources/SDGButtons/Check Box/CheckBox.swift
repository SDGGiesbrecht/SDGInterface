/*
 CheckBox.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif

  import SDGText
  import SDGLocalization

  import SDGViews

  /// A check box.
  @available(watchOS 6, *)
  public struct CheckBox<L>: LegacyView where L: Localization {

    // MARK: - Initialization

    /// Creates a button.
    ///
    /// - Parameters:
    ///     - label: The label on the button.
    public init(label: UserFacing<StrictString, L>) {
      self.label = label
    }

    // MARK: - Properties

    private let label: UserFacing<StrictString, L>

    // MARK: - LegacyView

    #if canImport(AppKit)
      public func cocoa() -> CocoaView {
        return useSwiftUIOrFallback(to: {
          return CocoaView(CocoaImplementation(label: label))
        })
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension CheckBox: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        #warning("Not implemented yet.")
        return SwiftUI.EmptyView()
      }
    #endif
  }
#endif
