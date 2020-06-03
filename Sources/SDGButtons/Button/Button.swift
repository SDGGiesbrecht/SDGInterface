/*
 Button.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGText
  import SDGLocalization

  import SDGViews

  /// A button.
  @available(watchOS 6, *)
  public struct Button<L>: LegacyView where L: Localization {

    // MARK: - Initialization

    /// Creates a button.
    ///
    /// - Parameters:
    ///    - label: The label on the button.
    ///    - action: The action the button should trigger.
    public init(label: UserFacing<StrictString, L>, action: @escaping () -> Void) {
      self.label = label
      self.action = action
    }

    // MARK: - Properties

    private let label: UserFacing<StrictString, L>
    private let action: () -> Void

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return useSwiftUIOrFallback(to: {
          return CocoaView(CocoaImplementation(label: label, action: action))
        })
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  private typealias View = SDGViews.View
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Button: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        return SwiftUIImplementation(
          label: label,
          action: action,
          localization: LocalizationSetting._observableCurrent
        )
      }
    #endif
  }
#endif
