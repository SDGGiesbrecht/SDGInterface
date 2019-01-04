/*
 ApplicationNameForm.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public enum ApplicationNameForm {
    // #workaround(These should be validated against the Info.plist entries seen by the system.)
    case english(EnglishRegion)
    public enum EnglishRegion {
        case unitedKingdom
        case unitedStates
        case canada
    }

    static func isolatedForm(for localizationCode: String) -> ApplicationNameForm? {
        switch localizationCode {
        case "en\u{2D}GB":
            return .english(.unitedKingdom)
        case "en\u{2D}US":
            return .english(.unitedStates)
        case "en\u{2D}CA":
            return .english(.canada)
        default:
            return nil
        }
    }

    static var isolatedForm: UserFacing<StrictString, ApplicationNameLocalization> {
        return UserFacing<StrictString, ApplicationNameLocalization>({ $0.correspondingIsolatedName })
    }
}
