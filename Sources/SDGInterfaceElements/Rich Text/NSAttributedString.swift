/*
 NSAttributedString.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension NSAttributedString : Comparable {

    /// Creates an attributed string from rich text.
    public convenience init(_ richText: RichText) {
        self.init(attributedString: richText.attributedString())
    }

    // MARK: - Comparable

    public static func <(precedingValue: NSAttributedString, followingValue: NSAttributedString) -> Bool {
        let precedingRaw = precedingValue.string
        let followingRaw = followingValue.string
        if precedingRaw < followingRaw {
            return true
        } else if precedingRaw > followingRaw {
            return false
        } else {
            return precedingValue.isLessThanOrEqual(to: followingValue)
        }
    }
}
