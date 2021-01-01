/*
 LabelledTextFieldPreview.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct LabelledTextFieldPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      Group {

        previewBothModes(
          LabelledTextField(
            label: Label(
              UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada:
                  return "Label"
                }
              })
            ),
            field: TextField(contents: Shared(""))
          ).adjustForLegacyMode(),
          name: "Default"
        )
      }
    }
  }
#endif
