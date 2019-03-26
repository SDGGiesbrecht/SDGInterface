/*
 NSTableColumn.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
extension NSTableColumn {

    // MARK: - Properties

    /// The header label.
    public var header: StrictString {
        set {
            let cell = headerCell
            cell.stringValue = String(newValue)
        }
        get {
            let cell = headerCell
            return StrictString(cell.stringValue)
        }
    }
}
#endif
