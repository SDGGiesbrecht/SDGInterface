/*
 NSAttributedString.Key.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGText

extension NSAttributedString.Key {
    #if !canImport(AppKit)
    // This fills in a hole in the API of `UIKit`. While absent from the API, `UIKit` methods generate attributed strings using this attribute the same way `AppKit` does.
    internal static let superscript = NSAttributedString.Key(rawValue: "NSSuperScript")
    #endif
    internal static let smallCaps = NSAttributedString.Key(rawValue: "SDGSmallCaps")
}

extension Dictionary where Key == NSAttributedString.Key, Value == Any {

    #if canImport(AppKit) || canImport(UIKit)
    /// Returns the font in the attribute dictionary.
    public var font: Font? {
        get {
            #if canImport(AppKit)
            typealias NativeFont = NSFont
            #elseif canImport(UIKit)
            typealias NativeFont = UIFont
            #endif
            if let font = self[.font] as? NativeFont {
                return Font(font)
            } else {
                return nil
            }
        }
        set {
            self[.font] = newValue?.native
        }
    }
    #endif
}
