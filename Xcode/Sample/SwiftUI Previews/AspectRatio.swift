/*
 AspectRatio.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftUI

import SDGMathematics

import SDGViews

struct AspectRatio_Previews: PreviewProvider {
  static var previews: some SwiftUI.View {

    let redSquare = Ellipse()
      .fill(Color.black)

    func preview<V>(_ view: V, name: String) -> some SwiftUI.View where V: SwiftUI.View {
      return
        view
        .previewLayout(.fixed(width: 124, height: 64))
        .previewDisplayName(name)
    }

    return Group {

      preview(
        redSquare
          .aspectRatio(nil, contentMode: .fill),
        name: "nil + .fill"
      )

      preview(
        redSquare
          .aspectRatio(nil, contentMode: .fit),
        name: "nil + .fit"
      )

      preview(
        redSquare
          .aspectRatio(1 ÷ 2, contentMode: .fill),
        name: "(1 ÷ 2) + .fill"
      )

      preview(
        redSquare
          .aspectRatio(1 ÷ 2, contentMode: .fit),
        name: "(1 ÷ 2) + .fit"
      )
    }
  }
}
