/*
 ApplicationNameLocalization.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization
internal struct ApplicationNameLocalization : Localization {

    private init(undefined: Void) {
        self.code = "und"
    }

    private var _correspondingIsolatedName: StrictString?
    internal var correspondingIsolatedName: StrictString {
        #warning("This needs a fallback of some sort.")
        return _correspondingIsolatedName ?? ""
    }

    // MARK: - Localization

    internal init?(exactly code: String) {
        guard let form = ApplicationNameForm.isolatedForm(for: code),
            let name = ProcessInfo.applicationName(form) else {
            return nil
        }
        self.code = code
        _correspondingIsolatedName = name
    }

    internal var code: String

    internal static var fallbackLocalization = ApplicationNameLocalization(undefined: ())
}
