/*
 UIView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit) && !os(watchOS)
  import UIKit

  import SDGLogic

  extension UIView {

    internal var controller: UIViewController? {
      var responder: UIResponder? = self
      while let next = responder?.next {
        responder = next
        if let cast = responder as? UIViewController {
          return cast
        }
      }
      return nil
    }
  }
#endif
