/*
 Error.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGText
import SDGLocalization

import SDGInterfaceLocalizations

extension Error {

    // MARK: - Display

    #if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
    /// Displays the error to the user.
    public func display() { // @exempt(from: tests) Requires user interaction.
        #if canImport(AppKit)
        let cocoaError = self as NSError
        var info = cocoaError.userInfo
        info[NSLocalizedDescriptionKey] = localizedDescription
        let modified = NSError(domain: cocoaError.domain, code: cocoaError.code, userInfo: info)
        NSAlert(error: modified).runModal()
        #else
        let alert = UIAlertController(title: localizedDescription, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: String(UserFacing<StrictString, InterfaceLocalization>({ localization in
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Cancel"
                case .deutschDeutschland:
                    return "Abbrechen"
                }
            }).resolved()),
            style: .cancel,
            handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        #endif
    }
    #endif
}
