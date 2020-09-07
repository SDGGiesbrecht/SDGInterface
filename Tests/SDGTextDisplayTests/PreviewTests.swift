/*
 PreviewTests.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGLocalization

  @testable import SDGTextDisplay

  import SDGInterfaceLocalizations

  import SDGViewsTestUtilities
  import SDGApplicationTestUtilities

  final class PreviewTests: ApplicationTestCase {

    func testLabelledTextFieldPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
            testViewConformance(of: LabelledTextFieldPreviews())
          }
        }
      }
    }

    func testLabelPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
            testViewConformance(of: LabelPreviews())
          }
        }
      }
    }

    func testTextViewPreviews() {
      for localization in InterfaceLocalization.allCases {
        LocalizationSetting(orderOfPrecedence: [localization.code]).do {
          if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
            testViewConformance(of: TextViewPreviews())
          }
        }
      }
    }
  }
#endif
