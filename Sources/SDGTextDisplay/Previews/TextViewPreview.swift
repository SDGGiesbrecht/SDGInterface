/*
 TextViewPreview.swift

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
                  SemanticMarkup("e") + SemanticMarkup("πi").superscripted()
                  + SemanticMarkup(" − 1 = 0")
                let sized = RichText(markup.richText(font: Font.forLabels.resized(to: 64)))
                var text = RichText()
                for letter in sized.prefix(3) {
                  var adjusted = letter
                  var font = adjusted.attributes[.font] as! NSFont
                  let italicized = SDGText.Font(font).italic
                  adjusted.attributes[.font] = NSFont.from(italicized)
                  text.append(adjusted)
                }
                text[...index(text.startIndex, offsetBy: 3)]
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
