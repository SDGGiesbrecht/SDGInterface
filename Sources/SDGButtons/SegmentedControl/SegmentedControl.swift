/*
 SegmentedControl.swift

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

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  import SDGViews

  /// A button.
  @available(watchOS 6, *)
  public struct SegmentedControl<Option, L>: LegacyView
  where Option: CaseIterable, Option: Equatable, L: Localization {

    // MARK: - Initialization

    /// Creates a button.
    ///
    /// - Parameters:
    ///    - label: A closure which generates a label from an option.
    ///    - selected: The selected option.
    public init(
      labels: @escaping (_ option: Option) -> UserFacing<ButtonLabel, L>,
      selection: Shared<Option>
    ) {
      self.labels = labels
      self.selection = selection
    }

    // MARK: - Properties

    private let labels: (_ option: Option) -> UserFacing<ButtonLabel, L>
    private let selection: Shared<Option>

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return useSwiftUIOrFallback(to: {
          return CocoaView(CocoaImplementation(labels: labels, selection: selection))
        })
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension SegmentedControl: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        return SwiftUIImplementation(
          labels: labels,
          selection: selection,
          localization: LocalizationSetting.current
        )
      }
    #endif
  }
#endif
