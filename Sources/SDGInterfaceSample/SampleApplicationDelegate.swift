/*
 SampleApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

#if !os(watchOS)

// @example(sample)
public final class SampleApplicationDelegate : ApplicationDelegate {

    public override func applicationDidFinishLaunching() {
        super.applicationDidFinishLaunching()
        setSamplesUp()
    }

    public override func openPreferences(_ sender: Any?) {
        print("Opening preferences...")
    }
}
// @endExample

extension SampleApplicationDelegate {

    public static func setUp() {
        ProcessInfo.applicationName = { form in
            switch form {
            case .english(let region):
                switch region {
                case .unitedKingdom, .unitedStates, .canada:
                    return "Sample"
                }
            case .español(let preposición):
                switch preposición {
                case .ninguna:
                    return "Ejemplar"
                case .de:
                    return "del Ejemplar"
                }
            case .deutsch(let fall):
                switch fall {
                case .nominativ, .akkusativ, .dativ:
                    return "Beispiel"
                }
            case .français(let préposition):
                switch préposition {
                case .aucune:
                    return "Exemple"
                case .de:
                    return "de l’Exemple"
                }

            case .ελληνικά(let πτώση):
                switch πτώση {
                case .ονομαστική:
                    return "Παράδειγμα"
                case .αιτιατική:
                    return "το Παράδειγμα"
                case .γενική:
                    return "του Παραδείγματος"
                }
            case .עברית:
                return "דוגמה"
            }
        }
    }

    public class func setUpAndMain() { // @exempt(from: tests)
        setUp()
        super.main()
    }

    private func setSamplesUp() {
        setMenuUp()
    }

    private func setMenuUp() {
        let menuItemLabel = Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Menu Item"
            }
        }))
        #if canImport(AppKit)
        let menuBar = MenuBar.menuBar
        let menu = menuBar.newApplicationSpecificSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Menu"
            }
        })))

        menu.newEntry(labelled: menuItemLabel)
        let indented = menu.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Indented"
            }
        })))
        indented.indentationLevel = 1
        menu.newSeparator()
        let submenu = menu.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Submenu"
            }
        })))
        submenu.newEntry(labelled: menuItemLabel)

        menu.newSeparator()

        let window = menu.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Window"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateWindow))
        window.target = self

        #elseif canImport(UIKit)

        #if os(tvOS)
        _ = menuItemLabel.value.resolved()
        #else
        let window = UIWindow(frame: UIScreen.main.bounds)
        permanentWindow = window
        let view = UIViewController()
        window.rootViewController = view
        let field = UITextView(frame: UIScreen.main.bounds)
        field.backgroundColor = UIColor.white
        view.view.addSubview(field)
        if BuildConfiguration.current == .debug,
            ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil { // #exempt(from: tests)
            // This call fails during tests.
            window.makeKeyAndVisible()
        }

        UIMenuController.shared.newEntry(labelled: menuItemLabel)
        UIMenuController.shared.update()
        #endif

        #endif
    }

    @objc private func demonstrateWindow() {
        let window = Window(title: "...", size: NSSize(width: 700, height: 300))
        window.makeKeyAndOrderFront(nil)
    }
}

#endif

#if canImport(UIKit) && !os(watchOS)
// #workaround(Temporary window storage.)
var permanentWindow: UIWindow?
#endif
