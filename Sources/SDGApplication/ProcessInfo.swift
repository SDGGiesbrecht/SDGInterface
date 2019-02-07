/*
 ProcessInfo.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceLocalizations

extension ProcessInfo {

    // #workaround(There should be a way to validate this against an expected set of localizations.)
    private static var _applicationName: ((ApplicationNameForm) -> StrictString?)?
    /// A closure which produces the declined application name suitable for use in various gramatical contexts.
    ///
    /// Applications must assign this property a value at the very beginning of program execution. Failing to do so before the first attempt to read this property will trigger a precondition failure.
    public static var applicationName: ((ApplicationNameForm) -> StrictString?) {
        get {
            guard let result = _applicationName else {
                preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                    switch localization {
                    case .englishCanada: // @exempt(from: tests)
                        return "“ProcessInfo.applicationName” has not been set yet. (Import SDGInterface or SDGApplication.)"
                    }
                }))
            }
            return result
        }
        set {
            _applicationName = newValue
        }
    }

    /// Validates the application bundle.
    ///
    /// This method is intended for use in tests. It does nothing when compiled in release mode.
    ///
    /// - Parameters:
    ///     - applicationBundle: The main application bundle.
    public static func validate(applicationBundle: Bundle) { // @exempt(from: tests)
        if BuildConfiguration.current == .debug {}
    }
}
