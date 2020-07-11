/*
 Anchor.Source.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI

  @available(macOS 10.15, *)
  extension Anchor.Source where Value == CGRect {

    /// Unwraps an instance of a shimmed `SDGPopOvers.RectangularAttachmentAnchor`.
    ///
    /// - Parameters:
    ///   - shimmed: The shimmed instance.
    public init(_ shimmed: RectangularAttachmentAnchor) {
      switch shimmed {
      case .bounds:
        self = .bounds
      case .rectangle(let rectangle):
        self = .rect(CGRect(rectangle))
      }
    }
  }
#endif
