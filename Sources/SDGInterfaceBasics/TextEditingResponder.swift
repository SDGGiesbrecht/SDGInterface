/*
 TextEditingResponder.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(Windows)  // #workaround(Swift 5.1.3, Windows trips over “@objc”?)
  // #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
  #if canImport(Foundation)
    import Foundation
  #endif

  /// An object which responds to actions related to editing text.
  @objc public protocol TextEditingResponder: TextDisplayResponder {

    /// Normalizes the selection to NFKD.
    ///
    /// - Parameters:
    ///     - sender: The sender.
    @objc func normalizeText(_ sender: Any?)
  }
#endif
