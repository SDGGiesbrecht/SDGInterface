/*
 ApplicationNameLocalization.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLocalization

/// A dynamic localization set based on the provided forms of the application’s name.
///
/// See `ProcessInfo.applicationName`.
public struct ApplicationNameLocalization : Localization {

    private init(undefined: Void) {
        self.code = "und"
    }

    private var _correspondingIsolatedName: StrictString?
    internal var correspondingIsolatedName: StrictString {
        if let defined = _correspondingIsolatedName {
            return defined
        } else if let infoPropertyList = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String {
            return StrictString(infoPropertyList) // @exempt(from: tests)
        } else {
            return StrictString(ProcessInfo.processInfo.processName)
        }
    }

    // MARK: - Localization

    public init?(exactly code: String) {
        guard let form = ApplicationNameForm.isolatedForm(for: code),
            let name = ProcessInfo.applicationName(form) else {
            return nil
        }
        self.code = code
        _correspondingIsolatedName = name
    }

    public var code: String

    public static var fallbackLocalization = ApplicationNameLocalization(undefined: ())
}
