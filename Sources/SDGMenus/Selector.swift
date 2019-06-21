/*
 Selector.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if canImport(ObjectiveC)
import ObjectiveC
#endif

extension Selector {
    private class Responder : NSObject {
        @objc fileprivate func unimplementedSelector(_ sender: Any?) {}
    }
    internal static let none: Selector = #selector(Responder.unimplementedSelector(_:))
}
