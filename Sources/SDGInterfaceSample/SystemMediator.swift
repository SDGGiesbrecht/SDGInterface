/*
 SystemMediator.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal class SystemMediator: SDGApplication.SystemMediator {

    internal func finishLaunching(_ details: SystemMediatorLaunchDetails) -> Bool {
        setSamplesUp()
        return true
    }

    private func setSamplesUp() {
        Application.shared.preferenceManager = PreferenceManager()
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
        let sample = menuBar.newApplicationSpecificSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Sample"
            }
        })))

        let menu = sample.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
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

        let error = sample.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Error"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateError))
        error.target = self

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
        })), action: #selector(SampleApplicationDelegate.demonstrateFullscreenWindow))
        fullscreen.target = self

        let view = sample.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "View"
            }
        })))

        let button = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Button"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateButton))
        button.target = self

        let buttonSet = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Button Set"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateButtonSet))
        buttonSet.target = self

        let checkBox = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Check Box"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateCheckBox))
        checkBox.target = self

        let image = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Image"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateImage))
        image.target = self

        let label = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateLabel))
        label.target = self

        let letterbox = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Letterbox"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateLetterbox))
        letterbox.target = self

        let textEditor = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Editor"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateTextEditor))
        textEditor.target = self

        let textField = view.newSubmenu(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Field"
            }
        })))

        let basicTextField = textField.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Field"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateTextField))
        basicTextField.target = self

        let labelledTextField = textField.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Labelled Text Field"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateLabelledTextField))
        labelledTextField.target = self

        #elseif canImport(UIKit)

        #if os(tvOS)
        _ = menuItemLabel.value.resolved()
        #else
        let window = Window(title: Shared(ApplicationNameForm.localizedIsolatedForm))
        let view = UIViewController()
        window.rootViewController = view
        let field = UITextView(frame: UIScreen.main.bounds)
        field.backgroundColor = UIColor.white
        view.view.addSubview(field)
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil { // #exempt(from: tests)
            // This call fails during tests.
            window.makeKeyAndVisible()
        }

        UIMenuController.shared.newEntry(labelled: menuItemLabel)
        UIMenuController.shared.update()
        #endif

        #endif
    }
}
