/*
 ColourContainer.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  extension Colour {
    internal class Container: NSView, CocoaViewImplementation {

      // MARK: - Initialization

      internal init(_ colour: Colour) {
        self.colour = colour
        super.init(frame: NSRect.zero)
      }

      internal required init?(coder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let colour: Colour

      // MARK: - NSView

      internal override func draw(_ dirtyRect: CGRect) {
        // @exempt(from: tests) Crashes without actual display available.
        NSColor(colour).setFill()
        dirtyRect.fill(using: .sourceOver)
        super.draw(dirtyRect)
      }
    }
  }
#endif
