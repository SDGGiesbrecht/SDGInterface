/*
 PopOverDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#warning("Audit.")

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
  import UIKit

  internal class UIPopoverPresentationControllerDelegate: NSObject, UIKit
      .UIPopoverPresentationControllerDelegate
  {

    internal static let delegate = UIPopoverPresentationControllerDelegate()

    internal func adaptivePresentationStyle(for controller: UIPresentationController)
      -> UIModalPresentationStyle
    {  // @exempt(from: tests)
      return .none
    }
  }
#endif
