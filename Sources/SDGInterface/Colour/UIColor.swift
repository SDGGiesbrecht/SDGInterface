/*
 UIColor.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit)
  import UIKit

  extension UIColor {

    /// Creates a Cocoa colour from a colour.
    ///
    /// - Parameters:
    ///   - colour: The colour.
    public convenience init(_ colour: Colour) {
      self.init(
        red: CGFloat(colour.red),
        green: CGFloat(colour.green),
        blue: CGFloat(colour.blue),
        alpha: CGFloat(colour.opacity)
      )
    }
  }
#endif
