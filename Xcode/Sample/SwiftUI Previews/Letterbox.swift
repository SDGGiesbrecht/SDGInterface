/*
 Letterbox.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI

  import SDGText
  import SDGLocalization

  import SDGViews
  import SDGTextDisplay

  import SDGInterfaceLocalizations

  struct Letterbox_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
      func makeView() -> Letterbox<TextEditor> {
        return Letterbox(content: TextEditor(), aspectRatio: 1)
      }
      return Group {

        makeView().swiftUIView
          .previewLayout(.fixed(width: 128, height: 64))
          .previewDisplayName("Pillarbox")

        makeView().swiftUIView
          .previewLayout(.fixed(width: 64, height: 128))
          .previewDisplayName("Letterbox")
      }
    }
  }
#endif
