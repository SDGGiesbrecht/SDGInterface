/*
 SampleApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)
// MARK: - #if !os(watchOS)

// [_Define Example: sample_]
public final class SampleApplicationDelegate : ApplicationDelegate {

    public override func applicationDidFinishLaunching() {
        super.applicationDidFinishLaunching()
        setUpSamples()
    }
}
// [_End_]

extension SampleApplicationDelegate {

    private func setUpSamples() {
        #if canImport(AppKit)
        let menuBar = LocalizedMenu(label: Shared(UserFacing<StrictString, InterfaceLocalization>({ _ in "" })))
        NSApplication.shared.mainMenu = menuBar
        menuBar.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ _ in "" })))
        let menu = menuBar.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Menu"
            }
        })))
        let menuItemLabel = Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Menu Item"
            }
        }))
        menu.newEntry(labelled: menuItemLabel)
        menu.newSeparator()
        let submenu = menu.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Submenu"
            }
        })))
        submenu.newEntry(labelled: menuItemLabel)
        #endif
    }
}

#endif
