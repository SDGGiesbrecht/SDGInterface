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

@testable import SDGViews

struct AspectRatio_Previews: PreviewProvider {
  static var previews: some SwiftUI.View {

    /// Previews in one mode.
    func preview<V>(_ view: () -> V, legacyMode: Bool) -> some SwiftUI.View where V: SwiftUI.View {
      let previous = SDGViews.legacyMode
      SDGViews.legacyMode = legacyMode
      defer { SDGViews.legacyMode = previous }
      return view()
        .frame(width: 124, height: 64)
        .padding(1)
        .border(Color.gray, width: 1)
    }

    /// Previews in both modes side‐by‐side.
    func preview<V>(_ view: @autoclosure () -> V, name: String) -> some SwiftUI.View
    where V: SwiftUI.View {
      let stack = HStack(spacing: 8) {
        preview(view, legacyMode: false)
        preview(view, legacyMode: true)
      }
      return
        stack
        .previewDisplayName(name)
    }

    let redSquare = Ellipse()
      .fill(Color.black)

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
