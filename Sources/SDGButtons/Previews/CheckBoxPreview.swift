/*
 CheckBoxPreview.swift

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
  internal struct CheckBoxPreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {

      return Group {

        previewBothModes(
          CheckBox(
            label: UserFacing<StrictString, InterfaceLocalization>({ localization in
              switch localization {
              case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Check Box"
              case .deutschDeutschland:
                return "Kontrollkästchen"
              }
            }),
            isChecked: Shared(false)
          ).adjustForLegacyMode()
            .padding(),
          name: "Check Box"
        )
      }
    }
  }

  struct CheckBox_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
      return CheckBoxPreviews()
    }
  }
#endif
