/*
 ProgressBarPreview.swift

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

  import SDGInterface

  import SDGInterfaceLocalizations

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct ProgressBarPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {
      Group {

        previewBothModes(
          ProgressBar(range: Shared(0...10), value: Shared(5)).adjustForLegacyMode(),
          name: "Half"
        )

        previewBothModes(
          ProgressBar(range: Shared(0...10), value: Shared(nil)).adjustForLegacyMode(),
          name: "Indeterminate"
        )
      }
    }
  }
#endif
