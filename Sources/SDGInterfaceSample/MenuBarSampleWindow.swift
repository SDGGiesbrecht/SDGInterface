/*
 MenuBarSampleWindow.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

import SDGMenus
import SDGMenuBar

import SDGInterfaceLocalizations

extension MenuBar {

    internal static func window() -> MenuEntry<InterfaceLocalization> {
        let window = sample.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Window"
            }
        })))
        let fullscreen = window.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Fullscreen"
            }
        })), action: #selector(Application.demonstrateFullscreenWindow))
        fullscreen.target = self
    }
}
