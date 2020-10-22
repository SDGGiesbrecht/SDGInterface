/*
 RichTextEditingResponder.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(Windows)  // #workaround(Swift 5.3, Causes linker error.)
  // #workaround(Swift 5.3, Web doesn’t have Foundation yet.)
  #if !os(WASI)
    import Foundation

    /// An object which responds to actions related to editing rich text.
    @objc public protocol RichTextEditingResponder: TextEditingResponder {

      // MARK: - Superscripts & Subscripts

      /// Superscripts the selection.
      ///
      /// - Parameters:
      ///     - sender: The sender.
      @objc func makeSuperscript(_ sender: Any?)

      /// Subscripts the selection.
      ///
      /// - Parameters:
      ///     - sender: The sender.
      @objc func makeSubscript(_ sender: Any?)

      /// Resets the baseline of the selection.
      ///
      /// - Parameters:
      ///     - sender: The sender.
      @objc func resetBaseline(_ sender: Any?)

      #if canImport(AppKit)
        // MARK: - Case

        /// Resets the casing of the selection.
        ///
        /// - Parameters:
        ///     - sender: The sender.
        @objc func resetCasing(_ sender: Any?)

        /// Converts the selection to a Latinate upper case font (where “i” becomes “I”).
        ///
        /// - Parameters:
        ///     - sender: The sender.
        @objc func makeLatinateUpperCase(_ sender: Any?)
        /// Converts the selection to a Turkic upper case font (where “i” becomes “İ”).
        ///
        /// - Parameters:
        ///     - sender: The sender.
        @objc func makeTurkicUpperCase(_ sender: Any?)

        /// Converts the selection to a Latinate small caps font (where “i” becomes “I”).
        ///
        /// - Parameters:
        ///     - sender: The sender.
        @objc func makeLatinateSmallCaps(_ sender: Any?)
        /// Converts the selection to a Turkic small caps font (where “i” becomes “İ”).
        ///
        /// - Parameters:
        ///     - sender: The sender.
        @objc func makeTurkicSmallCaps(_ sender: Any?)

        /// Converts the selection to a Latinate lower case font (where “I” becomes “i”).
        ///
        /// - Parameters:
        ///     - sender: The sender.
        @objc func makeLatinateLowerCase(_ sender: Any?)
        /// Converts the selection to a Turkic lower case font (where “I” becomes “ı”).
        ///
        /// - Parameters:
        ///     - sender: The sender.
        @objc func makeTurkicLowerCase(_ sender: Any?)
      #endif
    }
  #endif
#endif
