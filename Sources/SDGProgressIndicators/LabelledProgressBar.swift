/*
 LabelledProgressBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGText
  import SDGLocalization

  import SDGInterface
  import SDGTextDisplay

  /// A progress bar with a label.
  @available(watchOS 7, *)
  public struct LabelledProgressBar<L>: LegacyView where L: Localization {

    // MARK: - Initialization

    /// Creates a text field with label and a text field instances.
    ///
    /// - Parameters:
    ///     - label: The label.
    ///     - progressBar: A specific progress bar.
    public init(label: SDGTextDisplay.Label<L>, progressBar: ProgressBar) {
      self.label = label
      self.progressBar = progressBar
    }

    // MARK: - Properties

    /// The label.
    public let label: SDGTextDisplay.Label<L>
    /// The progress bar.
    public let progressBar: ProgressBar

    #if !os(watchOS)
      // MARK: - LegacyView

      public func cocoa() -> CocoaView {
        return useSwiftUIOrFallback(to: {
          let cocoaLabel = label.cocoa()
          let cocoaBar = progressBar.cocoa()

          let container = CocoaView()
          container.fill(with: cocoaLabel, on: .horizontal, margin: 0)
          container.fill(with: cocoaBar, on: .horizontal, margin: 0)
          container.position(
            subviews: [cocoaLabel, cocoaBar],
            inSequenceAlong: .vertical,
            padding: nil,
            margin: 0
          )
          return container.cocoa()
        })
      }
    #endif
  }

  // MARK: - View

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 7, *)
  extension LabelledProgressBar: View {

    #if !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        return VStack(alignment: .leading) {
          label.swiftUI()
          progressBar.swiftUI()
        }
      }
    #endif
  }
#endif
