/*
 SegmentedControlPreview.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(tvOS) || os(iOS) || os(watchOS))
  import SwiftUI

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  import SDGViews

  import SDGInterfaceLocalizations

  @available(macOS 10.15, *)
  internal struct SegmentedControlPreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {

      enum Direction: CaseIterable {
        case up
        case down
      }

      return Group {

        previewBothModes(
          SegmentedControl<Direction, InterfaceLocalization>(
            labels: { direction in
              switch direction {
              case .up:
                return UserFacing<ButtonLabel, InterfaceLocalization>({ localization in
                  switch localization {
                  case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return .text("Up")
                  case .deutschDeutschland:
                    return .text("Auf")
                  }
                })
              case .down:
                return UserFacing<ButtonLabel, InterfaceLocalization>({ localization in
                  switch localization {
                  case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return .text("Down")
                  case .deutschDeutschland:
                    return .text("Ab")
                  }
                })
              }
            },
            selection: Shared(.up)
          ).adjustForLegacyMode()
            .padding(),
          name: "Radio Buttons"
        )
      }
    }
  }
#endif
