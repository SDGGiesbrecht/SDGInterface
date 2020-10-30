/*
 ProgressBarPreview.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm)) && !os(watchOS)
  import SwiftUI

  import SDGControlFlow

  import SDGViews

  import SDGInterfaceLocalizations

  @available(macOS 10.15, tvOS 13, iOS 13, *)
  internal struct ProgressBarPreviews: SwiftUI.View {

    internal var body: some SwiftUI.View {

      return Group {
        ProgressBar(range: Shared(0...10), value: Shared(5))
          .swiftUI()
          .previewDisplayName("Half")

        ProgressBar(range: Shared(0...10), value: Shared(nil))
          .swiftUI()
          .previewDisplayName("Indeterminate")
      }
    }
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  struct ProgressBar_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
      return ProgressBarPreviews()
    }
  }
#endif
