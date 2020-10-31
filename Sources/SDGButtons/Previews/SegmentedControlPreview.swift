/*
 SegmentedControlPreview.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm)) && !os(watchOS)
  import SwiftUI

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  import SDGViews

  import SDGInterfaceLocalizations

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
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
