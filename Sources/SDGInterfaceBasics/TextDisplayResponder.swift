/*
 TextDisplayResponder.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(Windows)  // #workaround(workspace version 0.32.0, Windows trips over “@objc”?)
  // #workaround(Swift 5.2, Web doesn’t have Foundation yet.)
  #if !os(WASI)
    import Foundation

    /// An object which responds to actions related to displayed text.
    @objc public protocol TextDisplayResponder {

      /// Shows information about the selected characters.
      ///
      /// - Parameters:
      ///     - sender: The sender.
      @available(iOS 9, *)  // @exempt(from: unicode)
      @objc func showCharacterInformation(_ sender: Any?)
    }
  #endif
#endif
