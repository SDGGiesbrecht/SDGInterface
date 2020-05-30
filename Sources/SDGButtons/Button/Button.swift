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

  import SDGInterfaceBasics
  import SDGViews

  /// A button.
  @available(watchOS 6, *)
  public struct Button<L>: LegacyView where L: Localization {

    // MARK: - Initialization

    #warning("Rethink binding.")
    /// Creates a button.
    ///
    /// - Parameters:
    ///     - label: The label on the button.
    public init(label: SDGInterfaceBasics.Binding<StrictString, L>) {
      self.label = label
    }

    // MARK: - Properties

    private let label: SDGInterfaceBasics.Binding<StrictString, L>

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return useSwiftUIOrFallback(to: {
          return CocoaButtonImplementation(label: label).cocoa()
        })
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Button: SDGViews.View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        let labelString: UserFacing<StrictString, L>
        switch label {
        case .binding(let binding):
          labelString = UserFacing({ _ in binding.value })
        case .static(let `static`):
          labelString = `static`
        }
        return SwiftUIImplementation(
          label: .constant(labelString),
          action: {
            #warning("What goes here?")
          },
          localization: LocalizationSetting._observableCurrent
        )
      }
    #endif
  }

  #warning("Reduce and move elsewhere.")
  private typealias CocoaButtonImplementation = Button
#endif
