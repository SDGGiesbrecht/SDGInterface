/*
 RichTextPreviews.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

      func preview(
        text: UserFacing<StrictString, InterfaceLocalization>,
        transformation transform: @escaping (NSMutableAttributedString) -> Void
      ) -> some SwiftUI.View {
        return previewBothModes(
          TextView(
            contents: UserFacing<RichText, InterfaceLocalization>({ localization in
              let text: StrictString = text.resolved()
              var rich = RichText(rawText: text)
              rich.set(font: Font.forLabels.resized(to: 32))
              let attributed = NSMutableAttributedString(rich)
              transform(attributed)
              return RichText(attributed)
            })
          ).adjustForLegacyMode()
            .frame(
              width: 250,
              height: /*@START_MENU_TOKEN@*/ 100 /*@END_MENU_TOKEN@*/,
              alignment: /*@START_MENU_TOKEN@*/ .center /*@END_MENU_TOKEN@*/
            ),
          name: String(text.resolved())
        )
      }

      return Group {

        preview(
          text: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Upper Case"
            case .deutschDeutschland:
              return "Großbuchstaben"
            }
          }),
          transformation: { attributed in
            attributed.makeUpperCase(NSRange(location: 0, length: attributed.length))
          }
        )
        preview(
          text: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Small Upper Case"
            case .deutschDeutschland:
              return "Kapitälchen"
            }
          }),
          transformation: { attributed in
            attributed.makeSmallCaps(NSRange(location: 0, length: attributed.length))
          }
        )
        preview(
          text: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "Lower Case"
            case .deutschDeutschland:
              return "Kleinbuchstaben"
            }
          }),
          transformation: { attributed in
            attributed.makeLowerCase(NSRange(location: 0, length: attributed.length))
          }
        )
      }
    }
  }
#endif
