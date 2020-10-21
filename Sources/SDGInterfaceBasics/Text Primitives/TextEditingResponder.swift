/*
 TextEditingResponder.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

//#if !os(Windows)  // #warning(Swift 5.2.4, Causes linker error.)
  // #workaround(Swift 5.3, Web doesn’t have Foundation yet.)
  #if !os(WASI)
    import Foundation

    /// An object which responds to actions related to editing text.
    @objc public protocol TextEditingResponder: TextDisplayResponder {

      /// Normalizes the selection to NFKD.
      ///
      /// - Parameters:
      ///     - sender: The sender.
      @objc func normalizeText(_ sender: Any?)
    }
  #endif
//#endif
