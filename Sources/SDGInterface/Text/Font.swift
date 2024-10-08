/*
 Font.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

import SDGText

extension Font {

  // MARK: - System Fonts

  /// The default font.
  public static var `default`: Font {
    return forTextEditing
  }

  /// The label font.
  public static var forLabels: Font {
    #if canImport(AppKit)
      return Font(NSFont.systemFont(ofSize: NSFont.systemFontSize(for: .regular)))
    #elseif canImport(UIKit)
      return Font(UIFont.preferredFont(forTextStyle: .headline))
    #else
      return system
    #endif
  }

  /// The default font for text editing.
  public static var forTextEditing: Font {
    var user: Font?
    #if canImport(AppKit)
      user = NSFont.userFont(ofSize: NSFont.systemFontSize).map { Font($0) }
    #endif
    return user ?? system  // @exempt(from: tests) Unknown why it would ever be nil on macOS.
  }

  // MARK: - Modified Versions

  #if canImport(AppKit) || canImport(UIKit)
    /// The bold version of `self`.
    public var bold: Font {
      #if canImport(AppKit)
        guard let cocoa = NSFont.from(self) else {
          return self  // @exempt(from: tests)
        }
        return Font(NSFontManager.shared.convert(cocoa, toHaveTrait: .boldFontMask))
      #else
        guard let cocoa = UIFont.from(self) else {
          // @exempt(from: tests)
          return self
        }
        let descriptor =
          cocoa.fontDescriptor.withSymbolicTraits(.traitBold)
          // Unknown why the descriptor would be nil.
          ?? cocoa.fontDescriptor  // @exempt(from: tests)
        return Font(UIFont(descriptor: descriptor, size: 0))
      #endif
    }
  #endif

  #if canImport(AppKit) || canImport(UIKit)
    /// The italic version of `self`.
    public var italic: Font {
      #if canImport(AppKit)
        guard let cocoa = NSFont.from(self) else {
          return self  // @exempt(from: tests)
        }
        return Font(NSFontManager.shared.convert(cocoa, toHaveTrait: .italicFontMask))
      #else
        guard let cocoa = UIFont.from(self) else {
          // @exempt(from: tests)
          return self
        }
        let descriptor =
          cocoa.fontDescriptor.withSymbolicTraits(.traitItalic)
          // Unknown why the descriptor would be nil.
          ?? cocoa.fontDescriptor  // @exempt(from: tests)
        return Font(UIFont(descriptor: descriptor, size: 0))
      #endif
    }
  #endif
}
