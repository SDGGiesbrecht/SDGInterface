/*
 ProgressBar.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

import SDGControlFlow
import SDGMathematics

extension ProgressBar {

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    @available(macOS 11, tvOS 14, iOS 14, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      @ObservedObject var range: Shared<ClosedRange<Double>>
      @ObservedObject var value: Shared<Double?>

      // MARK: - View

      internal var body: some SwiftUI.View {
        let view: ProgressView<EmptyView, EmptyView>
        if let value = value.value {
          let progress = ProgressBar.zeroToOneRepresentation(of: value, in: range.value)
          view = ProgressView(value: progress)
        } else {
          view = ProgressView()
        }
        return view.progressViewStyle(LinearProgressViewStyle())
      }
    }
  #endif
}
