/*
 SampleApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

#if !os(watchOS)
// MARK: - #if !os(watchOS)

// @example(sample)
public final class SampleApplicationDelegate : ApplicationDelegate {

    public override func applicationDidFinishLaunching() {
        super.applicationDidFinishLaunching()
        setUpSamples()
    }
}
// @endExample

extension SampleApplicationDelegate {

    private func setUpSamples() {
        setUpMenu()
    }

    private func setUpMenu() {
        let menuItemLabel = Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Menu Item"
            }
        }))
        #if canImport(AppKit)
        let menuBar = LocalizedMenu(label: Shared(UserFacing<StrictString, InterfaceLocalization>({ _ in "" })))
        Application.shared.mainMenu = menuBar
        menuBar.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ _ in "" })))
        let menu = menuBar.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Menu"
            }
        })))

        menu.newEntry(labelled: menuItemLabel)
        menu.newSeparator()
        let submenu = menu.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Submenu"
            }
        })))
        submenu.newEntry(labelled: menuItemLabel)
        #elseif canImport(UIKit)
        let window = UIWindow(frame: UIScreen.main.bounds)
        permanentWindow = window
        let view = UIViewController()
        window.rootViewController = view
        let field = UITextView(frame: UIScreen.main.bounds)
        field.backgroundColor = UIColor.white
        view.view.addSubview(field)
        window.makeKeyAndVisible()

        UIMenuController.shared.newEntry(labelled: menuItemLabel)
        UIMenuController.shared.update()
        #endif
    }
}

#endif

#if canImport(UIKit)
// [_Workaround: Temporary window storage._]
var permanentWindow: UIWindow?
#endif
