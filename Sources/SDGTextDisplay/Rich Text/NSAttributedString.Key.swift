/*
 NSAttributedString.Key.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3, Web doesn’t have Foundation yet.)
#if !os(WASI)
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
          #if canImport(AppKit)
            typealias NativeFont = NSFont
          #elseif canImport(UIKit)
            typealias NativeFont = UIFont
          #endif
          self[.font] = newValue.flatMap { NativeFont.from($0) }
        }
      }
    #endif

    #if canImport(AppKit) || canImport(UIKit)
      internal mutating func update(fontFeatures: [Int: Int]) {
        #if canImport(AppKit)
          typealias NativeFont = NSFont
        #elseif canImport(UIKit)
          typealias NativeFont = UIFont
        #endif
        if let font = (self[.font] as? NativeFont)
          ?? NativeFont.from(Font.default)
        {
          let descriptor = font.fontDescriptor
          let existingFeatures =
            descriptor.fontAttributes[.featureSettings]
            as? [[NSFontDescriptor.FeatureKey: Int]] ?? []

          var featureDictionary: [Int: Int] = [:]
          for feature in existingFeatures {
            // @exempt(from: tests) System doesn’t report existing features?
            if let type = feature[.typeIdentifier],
              let selector = feature[.selectorIdentifier]
            {
              featureDictionary[type] = selector
            }
          }

          featureDictionary = featureDictionary.mergedByOverwriting(from: fontFeatures)

          var featureArray: [[NSFontDescriptor.FeatureKey: Int]] = []
          for (type, selector) in featureDictionary {
            featureArray.append([
              .typeIdentifier: type,
              .selectorIdentifier: selector,
            ])
          }

          let newDescriptor = descriptor.addingAttributes([.featureSettings: featureArray])
          let newFont = NativeFont(descriptor: newDescriptor, size: font.pointSize)
          self[.font] = newFont
        }
      }
    #endif
  }
#endif
