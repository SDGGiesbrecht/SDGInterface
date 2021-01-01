/*
 TablePreview.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm)) && !os(watchOS)
  import SwiftUI

  import SDGControlFlow

  import SDGViews

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct TablePreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      Group {
        Table(
          data: Shared<[(String, String)]>([
            ("3", "III"),
            ("2", "II"),
            ("1", "I"),
          ]),
          columns: [
            { SDGViews.AnyView(Text(verbatim: $0.0)) },
            { SDGViews.AnyView(Text(verbatim: $0.1)) },
          ],
          sort: { $0.0 < $1.0 }
        )
        .swiftUI()
        .previewDisplayName("Table")
      }
    }
  }
#endif
