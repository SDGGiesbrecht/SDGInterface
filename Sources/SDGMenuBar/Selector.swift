/*
 Selector.swift

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

extension Selector {

    // MARK: - Static Properties

    /// The action which opens the preferences.
    public static let openPreferences: Selector = #selector(_NSApplicationDelegateProtocol.openPreferences(_:))

    private class Responder : NSObject {
        @objc fileprivate func undo(_ sender: Any?) {}
        @objc fileprivate func redo(_ sender: Any?) {}
    }
    public static let undo: Selector = #selector(Responder.undo(_:))
    public static let redo: Selector = #selector(Responder.redo(_:))
}
