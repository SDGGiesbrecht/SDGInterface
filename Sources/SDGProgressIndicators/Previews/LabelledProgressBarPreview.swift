/*
 LabelledProgressBarPreview.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  import SDGInterface

  import SDGInterfaceLocalizations

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 7, *)
  internal struct LabelledProgressBarPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      Group {

        previewBothModes(
          LabelledProgressBar(
            label: Label(
              UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada:
                  return "Label"
                }
              })
            ),
            progressBar: ProgressBar(range: Shared(0...10), value: Shared(5))
          ).adjustForLegacyMode(),
          name: "Progress Bar"
        )
      }
    }
  }
#endif
