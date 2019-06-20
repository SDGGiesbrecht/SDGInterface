/*
 MenuBarSample.swift

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

    private static func error() -> MenuEntry<InterfaceLocalization> {
        let error = sample.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Error"
            }
        })), action: #selector(Application.demonstrateError))
        error.target = self
    }

    private static func sample() -> Menu<InterfaceLocalization> {
        let sample = Menu(label: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Sample"
            }
        })))
        sample.entries = [
            .entry(error()),
            .submenu(menu()),
            .entry(view()),
            .entry(window())
        ]
        return sample
    }
    internal func setUpSamples() {
        addApplicationSpecificSubmenu(MenuBar.sample())
    }
}
