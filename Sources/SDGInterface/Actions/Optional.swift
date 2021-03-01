/*
 Optional.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(ObjectiveC)
  import ObjectiveC

  extension Optional where Wrapped == Selector {

    // MARK: - Actions

    public func action(target: Any?, sender: Any?) -> () -> Void {
      if let selector = self {
        return selector.action(target: target, sender: sender)
      } else {
        return {}
      }
    }
  }
#endif
