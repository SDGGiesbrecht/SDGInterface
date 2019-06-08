/*
 Application.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGLocalization

#if !os(watchOS)

extension Application {

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
        Application.main(mediator: SystemMediator())
    }

    internal static func setSamplesUp() {
        Application.shared.preferenceManager = PreferenceManager()
        setMenuUp()
    }

    private static func setMenuUp() {
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
        })), action: #selector(Application.demonstrateError))
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
        })), action: #selector(Application.demonstrateFullscreenWindow))
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
        })), action: #selector(Application.demonstrateButton))
        button.target = self

        let buttonSet = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Button Set"
            }
        })), action: #selector(Application.demonstrateButtonSet))
        buttonSet.target = self

        let checkBox = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Check Box"
            }
        })), action: #selector(Application.demonstrateCheckBox))
        checkBox.target = self

        let image = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Image"
            }
        })), action: #selector(Application.demonstrateImage))
        image.target = self

        let label = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        })), action: #selector(Application.demonstrateLabel))
        label.target = self

        let letterbox = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Letterbox"
            }
        })), action: #selector(Application.demonstrateLetterbox))
        letterbox.target = self

        let textEditor = view.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Editor"
            }
        })), action: #selector(Application.demonstrateTextEditor))
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
        })), action: #selector(Application.demonstrateTextField))
        basicTextField.target = self

        let labelledTextField = textField.newEntry(labelled: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Labelled Text Field"
            }
        })), action: #selector(Application.demonstrateLabelledTextField))
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
            = Shared(UserFacing({ _ in .image(Image()) }))
        demonstrate(ButtonSet<InterfaceLocalization>(segments: [
            (label: firstLabel, action: #selector(Application.doNothing), target: self),
            (label: secondLabel, action: #selector(Application.doNothing), target: self)
            ]), windowTitle: label)
    }

    #if canImport(AppKit)
    @objc public func demonstrateCheckBox() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Check Box"
            }
        })
        demonstrate(CheckBox(label: Shared(label)), windowTitle: label)
    }
    #endif

    @objc public func demonstrateError() { // @exempt(from: tests) Requires user interaction.
        let error = TextConvertibleNumberParseError.invalidDigit("π", entireString: "3π")
        error.display()
    }

    @objc public func demonstrateImage() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Image"
            }
        })
        demonstrate(ImageView(), windowTitle: label)
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

    @objc public func demonstrateLabelledTextField() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Labelled Text Field"
            }
        })
        demonstrate(LabelledTextField(labelText: label), windowTitle: label)
    }

    @objc public func demonstrateLetterbox() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Letterbox"
            }
        })
        demonstrate(Letterbox(content: TextEditor(), aspectRatio: 1), windowTitle: label)
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

    @objc public func demonstrateFullscreenWindow() {
        let window = FullscreenWindow(title: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Fullscreen Window"
            }
        })))
        demonstrate(window)
    }

    @objc private func doNothing() { // @exempt(from: tests)
    }
}

#endif
