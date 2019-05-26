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

        let window = sample.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Window"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateWindow))
        window.target = self

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

        let label = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateLabel))
        label.target = self

        let textEditor = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Editor"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateTextEditor))
        textEditor.target = self

        let textField = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Field"
            }
        })), action: #selector(SampleApplicationDelegate.demonstrateTextField))
        textField.target = self

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

    private func demonstrate(_ window: NSWindow) {
        window.makeKeyAndOrderFront(nil)
    }
    private func demonstrate<L>(_ view: View, windowTitle: UserFacing<StrictString, L>) {
        #if canImport(AppKit)
        let window = AuxiliaryWindow(title: Shared(windowTitle))
        window.contentView?.fill(with: view)
        demonstrate(window)
        #else
        let window = Window(title: Shared(windowTitle))
        let frame = UIViewController()
        window.rootViewController = frame
        frame.view.fill(with: view)
        demonstrate(window)
        #endif
    }

    @objc public func demonstrateButton() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Button"
            }
        })
        demonstrate(Button(label: Shared(label)), windowTitle: label)
    }

    @objc public func demonstrateButtonSet() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "ButtonSet"
            }
        })
        let firstLabel: Shared<UserFacing<ButtonSetSegmentLabel, InterfaceLocalization>>
            = Shared(UserFacing({ _ in .text("Segment") }))
        let secondLabel: Shared<UserFacing<ButtonSetSegmentLabel, InterfaceLocalization>>
            = Shared(UserFacing({ _ in .image(NSImage()) }))
        demonstrate(ButtonSet<InterfaceLocalization>(segments: [
            (label: firstLabel, action: #selector(SampleApplicationDelegate.doNothing), target: self),
            (label: secondLabel, action: #selector(SampleApplicationDelegate.doNothing), target: self)
            ]), windowTitle: label)
    }

    @objc public func demonstrateCheckBox() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Check Box"
            }
        })
        demonstrate(CheckBox(label: Shared(label)), windowTitle: label)
    }

    @objc public func demonstrateLabel() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        })
        demonstrate(Label(text: Shared(label)), windowTitle: label)
    }

    @objc public func demonstrateTextEditor() {
        demonstrate(TextEditor(), windowTitle: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Editor"
            }
        }))
    }

    @objc public func demonstrateTextField() {
        demonstrate(TextField(), windowTitle: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Field"
            }
        }))
    }

    @objc public func demonstrateWindow() {
        let window = Window(title: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Window"
            }
        })), size: CGSize(width: 700, height: 300))
        demonstrate(window)
    }

    @objc private func doNothing() { // @exempt(from: tests)
    }
}

#endif
