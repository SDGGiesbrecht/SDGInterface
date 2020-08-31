/*
 TextViewPreview.swift

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
  internal struct TextViewPreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {

      return Group {

        previewBothModes(
          TextView(
            contents: UserFacing<RichText, InterfaceLocalization>({ localization in
              switch localization {
              case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                .deutschDeutschland:
                let markup =
                  SemanticMarkup("e")
                  + SemanticMarkup("πi").superscripted()
                  + SemanticMarkup(" − 1 = 0")
                var text = RichText(markup.richText(font: Font.forLabels.resized(to: 32)))
                text.italicize(range: ..<text.index(text.startIndex, offsetBy: 3))
                return text
              }
            })
          ).adjustForLegacyMode(),
          name: "Default"
        )
      }
    }
  }
#endif
