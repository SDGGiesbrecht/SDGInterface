/*
 SegmentedControl.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(SwiftUI) && !os(watchOS)) || canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
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

  import SDGInterfaceLocalizations

  /// A button.
  public struct SegmentedControl<Option, L>: LegacyView
  where Option: CaseIterable, Option: Hashable, L: Localization {

    // MARK: - Initialization

    /// Creates a button.
    ///
    /// - Parameters:
    ///    - labels: A closure which generates a label from an option.
    ///    - selection: The selected option.
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

    #if canImport(AppKit) || canImport(UIKit)
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

    #if canImport(SwiftUI)
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

#if canImport(SwiftUI) && !os(watchOS)
  @available(macOS 10.15, tvOS 13, iOS 13, *)
  internal struct SegmentedControlPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      enum Direction: CaseIterable {
        case left
        case right
      }

      return Group {

        previewBothModes(
          SegmentedControl<Direction, InterfaceLocalization>(
            labels: { direction in
              switch direction {
              case .left:
                return UserFacing<ButtonLabel, InterfaceLocalization>({ localization in
                  switch localization {
                  case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return .text("Left")
                  case .deutschDeutschland:
                    return .text("Links")
                  }
                })
              case .right:
                return UserFacing<ButtonLabel, InterfaceLocalization>({ localization in
                  switch localization {
                  case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return .text("Right")
                  case .deutschDeutschland:
                    return .text("Rechts")
                  }
                })
              }
            },
            selection: Shared(.left)
          ).adjustForLegacyMode()
            .padding(),
          name: "Text"
        )

        previewBothModes(
          SegmentedControl<Direction, InterfaceLocalization>(
            labels: { direction in
              switch direction {
              case .left:
                return UserFacing<ButtonLabel, InterfaceLocalization>({ localization in
                  switch localization {
                  case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                    .deutschDeutschland:
                    #if canImport(AppKit)
                      return .symbol(.goLeft)
                    #else
                      return .symbol(.empty)
                    #endif
                  }
                })
              case .right:
                return UserFacing<ButtonLabel, InterfaceLocalization>({ localization in
                  switch localization {
                  case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                    .deutschDeutschland:
                    #if canImport(AppKit)
                      return .symbol(.goRight)
                    #else
                      return .symbol(.empty)
                    #endif
                  }
                })
              }
            },
            selection: Shared(.left)
          ).adjustForLegacyMode()
            .padding(),
          name: "Symbols"
        )
      }
    }
  }
#endif
