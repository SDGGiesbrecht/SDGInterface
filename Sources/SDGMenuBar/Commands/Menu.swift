/*
 Menu.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGInterface

extension SDGInterface.Menu: LegacyCommands {

  // MARK: - LegacyCommands

  public func menuComponents() -> Self {
    return self
  }
}

@available(macOS 11, *)
extension SDGInterface.Menu: Commands where Components: SDGInterface.MenuComponents {

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    public func swiftUICommands() -> some SwiftUI.Commands {
      #warning("Needs a separate type to track localization.")
      return CommandMenu(String(label.resolved())) {
        self.swiftUI()
      }
    }
  #endif
}
