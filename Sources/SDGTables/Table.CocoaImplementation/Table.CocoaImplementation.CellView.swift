/*
 Table.CocoaImplementation.CellView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGViews

  extension Table.CocoaImplementation {
    internal class CellView: AppKit.NSTableCellView {

      // MARK: - Initialization

      internal init<Content>(view: Content) where Content: LegacyView {
        self.view = view.cocoa()
        super.init(frame: .zero)
        let wrapped = CocoaView(self)
        wrapped.fill(with: self.view, on: .vertical, margin: 0)
        wrapped.fill(with: self.view, on: .horizontal, margin: 1)
      }

      internal required init?(coder decoder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let view: CocoaView
    }
  }
#endif
