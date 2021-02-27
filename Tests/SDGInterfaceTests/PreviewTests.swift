/*
 PreviewTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGLocalization

  @testable import SDGInterface

  import SDGInterfaceLocalizations

  import SDGInterfaceTestUtilities
  import SDGApplicationTestUtilities

  final class PreviewTests: ApplicationTestCase {

    func testButtonPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
            _ = ButtonPreviews.previews
          }
        }
      }
    }

    func testCheckBoxPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 10.15, iOS 13, watchOS 6, *) {
            #if !(os(tvOS) || os(iOS))
              _ = CheckBoxPreviews.previews
            #endif
          }
        }
      }
    }

    func testFramedPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = FramedPreviews.previews
      }
    }

    func testHorizontalStackPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = HorizontalStackPreviews.previews
      }
    }

    func testImagePreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = ImagePreviews.previews
      }
    }

    func testLabelledTextFieldPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
            _ = LabelledTextFieldPreviews.previews
          }
        }
      }
    }

    func testLabelPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
            _ = LabelPreviews.previews
          }
        }
      }
    }

    func testLetterboxPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = LetterboxPreviews.previews
      }
    }

    func testLayeredPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = LayeredPreviews.previews
      }
    }

    func testPaddedPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = PaddedPreviews.previews
      }
    }

    func testProportionedPreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = ProportionedPreviews.previews
      }
    }

    func testRichTextPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
            _ = RichTextPreviews.previews
          }
        }
      }
    }

    func testSegmentedControlPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
            _ = SegmentedControlPreviews.previews
          }
        }
      }
    }

    func testTablePreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
        _ = TablePreviews.previews
      }
    }

    func testTextViewPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
            _ = TextViewPreviews.previews
          }
        }
      }
    }
  }
#endif
