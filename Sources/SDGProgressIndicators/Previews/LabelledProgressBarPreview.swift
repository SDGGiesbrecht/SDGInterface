/*
 LabelledProgressBarPreview.swift

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

  import SDGInterfaceLocalizations
  import SDGTextDisplay

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct LabelledProgressBarPreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {

      return Group {

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

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  struct LabelledProgressBar_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
      return LabelledProgressBarPreviews()
    }
  }
#endif
