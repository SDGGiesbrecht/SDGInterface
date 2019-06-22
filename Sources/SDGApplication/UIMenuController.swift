/*
 UIMenuController.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import UIKit

import SDGInterfaceElements
import SDGMenuBar

import SDGInterfaceLocalizations

extension UIMenuController {

    internal func extend() {

        var entries = UIMenuController.shared.menuItems ?? []
        entries.append(contentsOf: [
            MenuBar._normalizeText(),
            MenuBar._showCharacterInformation()
            ].map({ $0.native }))
        UIMenuController.shared.menuItems = entries

        UIMenuController.shared.update()
    }
}
#endif
