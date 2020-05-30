/*
 ButtonPreview.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics
  import SDGViews

  import SDGInterfaceLocalizations

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct ButtonPreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {

      return Group {

        previewBothModes(
          Button(
            label: UserFacing<StrictString, InterfaceLocalization>({ localization in
              switch localization {
              case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Button"
              case .deutschDeutschland:
                return "Taste"
              }
            })
          ).adjustForLegacyMode()
            .padding(),
          name: "Button"
        )
      }
    }
  }
#endif
