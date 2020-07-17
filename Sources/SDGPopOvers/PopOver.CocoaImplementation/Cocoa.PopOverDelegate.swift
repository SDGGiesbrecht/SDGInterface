/*
 Cocoa.PopOverDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit) && !os(tvOS) && !os(watchOS)
  import UIKit

  import SDGViews

  extension CocoaView {

    internal class PopOverDelegate: NSObject, UIKit.UIPopoverPresentationControllerDelegate {

      internal static let delegate = PopOverDelegate()

      internal func adaptivePresentationStyle(
        for controller: UIPresentationController
      ) -> UIModalPresentationStyle {  // @exempt(from: tests)
        return .none
      }
    }
  }
#endif
