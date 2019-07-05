/*
 NSArrayController.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

#if !canImport(AppKit)
/// A drop‐in replacement for some uses of `AppKit`’s `NSArrayController` in `UIKit` environments.
public final class NSArrayController : NSObject {

    // MARK: - Initialization

    public override init() {
        content = []
    }

    /// Creates an array controller with a content array.
    ///
    /// - Parameters:
    ///     - content: The content array.
    public init(content: [NSObject]) {
        self.content = content
    }

    // MARK: - Properties

    private var content: [NSObject]

    /// The arranged content.
    public var arrangedObjects: [NSObject] {
        return content
    }

    /// Whether or not the controller automatically rearranges its content.
    public var automaticallyRearrangesObjects: Bool = false
}
#endif
