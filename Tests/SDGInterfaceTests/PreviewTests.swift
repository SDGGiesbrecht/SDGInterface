/*
 PreviewTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI

  import SDGLocalization

  @testable import SDGInterface

  import SDGInterfaceLocalizations

  import SDGInterfaceTestUtilities
  import SDGInterfaceInternalTestUtilities

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
          if #available(macOS 10.15, *) {
            #if !(os(tvOS) || os(iOS) || os(watchOS))
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

    func testMenuPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 11, tvOS 13, iOS 14, watchOS 6, *) {
            _ = MenuPreviews.previews
          }
        }
      }
    }

    func testMenuEntryPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 11, tvOS 13, iOS 14, watchOS 6, *) {
            _ = MenuEntryPreviews.previews
          }
        }
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
          if #available(macOS 10.15, tvOS 13, iOS 13, *) {
            #if !os(watchOS)
              _ = RichTextPreviews.previews
            #endif
          }
        }
      }
    }

    func testSegmentedControlPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 10.15, tvOS 13, iOS 13, *) {
            #if !os(watchOS)
              _ = SegmentedControlPreviews.previews
            #endif
          }
        }
      }
    }

    func testTablePreviews() {
      if #available(macOS 10.15, tvOS 13, iOS 13, *) {
        #if !os(watchOS)
          _ = TablePreviews.previews
        #endif
      }
    }

    func testTextViewPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 10.15, tvOS 13, iOS 13, *) {
            #if !os(watchOS)
              _ = TextViewPreviews.previews
            #endif
          }
        }
      }
    }
  }
#endif
