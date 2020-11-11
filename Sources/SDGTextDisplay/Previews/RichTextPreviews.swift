/*
 RichTextPreviews.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm)) && !os(watchOS)
import SwiftUI

  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics
  import SDGViews

  import SDGInterfaceLocalizations

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct RichTextPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      Group {

        previewBothModes(
          TextView(
            contents: UserFacing<RichText, InterfaceLocalization>({ localization in
              let text: StrictString
              switch localization {
              case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                text = "Small Upper Case"
              case .deutschDeutschland:
                text = "Kapitälchen"
              }
              var rich = RichText(rawText: text)
              rich.set(font: Font.forLabels.resized(to: 32))
              let attributed = NSMutableAttributedString(rich)
              attributed.makeLatinateSmallCaps(NSRange(location: 0, length: attributed.length))
              return RichText(attributed)
            })
          ).adjustForLegacyMode(),
          name: "Small Upper Case"
        )
      }
    }
  }
#endif
