/*
 Selector.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(ObjectiveC)
  import Foundation
  import ObjectiveC

  #if canImport(AppKit)
    import AppKit
  #endif

  extension Selector {

    // MARK: - None

    private class Responder: NSObject {
      @objc fileprivate func unimplementedSelector(_ sender: Any?) {}  // @exmpt(from: tests)
    }
    internal static let none: Selector = #selector(Responder.unimplementedSelector(_:))

    // MARK: - Actions

    #if canImport(AppKit)
      public func action(target: Any? = nil, sender: Any? = nil) -> () -> Void {
        return {
          NSApplication.shared.sendAction(self, to: target, from: sender)
        }
      }
    #endif
  }
#endif
