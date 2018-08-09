/*
 MenuBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceLocalizations

public class MenuBar : LocalizedMenu<MenuBarLocalization> {

    internal init() {
        super.init(label: Shared(UserFacing<StrictString, MenuBarLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Main Menu"
            }
        })))
    }
}
