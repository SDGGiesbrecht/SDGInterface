/*
 PopoverAttachmentAnchor.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension PopoverAttachmentAnchor {

    /// Unwraps an instance of a shimmed `SDGInterface.AttachementAnchor`.
    ///
    /// - Parameters:
    ///   - shimmed: The shimmed instance.
    public init(_ shimmed: AttachmentAnchor) {
      switch shimmed {
      case .point(let point):
        self = .point(UnitPoint(point))
      case .rectangle(let rectangle):
        self = .rect(Anchor<CGRect>.Source(rectangle))
      }
    }
  }
#endif
