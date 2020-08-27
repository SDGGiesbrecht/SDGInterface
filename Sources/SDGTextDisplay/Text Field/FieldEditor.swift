/*
 FieldEditor.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit

  import SDGInterfaceLocalizations

  internal class FieldEditor: TextEditor.CocoaDocumentView {
    internal override init() {
      super.init()
      self.isFieldEditor = true
    }
    internal required init?(coder: NSCoder) {  // @exempt(from: tests)
      super.init(coder: coder)
    }
  }
#endif
