/*
 LabelledProgressBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGText
  import SDGLocalization

  import SDGInterfaceBasics
  import SDGViews
  import SDGTextDisplay

  /// A progress bar with a label.
  public final class LabelledProgressBar<L>: CocoaViewImplementation, View where L: Localization {

    // MARK: - Initialization

    /// Creates a text field with label text.
    ///
    /// - Parameters:
    /// 	- labelText: The text for the label.
    public convenience init(labelText: Binding<StrictString, L>) {
      let label = Label(text: labelText)
      self.init(label: label)
    }

    /// Creates a text field with label and a text field instances.
    ///
    /// - Parameters:
    ///     - label: The label.
    ///     - progressBar: Optional. A specific progress bar.
    public init(label: Label<L>, progressBar: ProgressBar? = nil) {
      self.label = label
      let cocoaLabel = label.cocoa()
      let constructedBar = progressBar ?? ProgressBar()
      self.progressBar = constructedBar
      let cocoaBar = constructedBar.cocoa()
      container = CocoaView()
      container.fill(with: cocoaLabel, on: .horizontal, margin: 0)
      container.fill(with: cocoaBar, on: .horizontal, margin: 0)
      container.position(
        subviews: [cocoaLabel, cocoaBar],
        inSequenceAlong: .vertical,
        padding: nil,
        margin: 0
      )
    }

    // MARK: - Properties

    private let container: CocoaView

    /// The label.
    public let label: Label<L>
    /// The progress bar.
    public let progressBar: ProgressBar

    // MARK: - View

    public func cocoa() -> CocoaView {
      return container.cocoa()
    }
  }
#endif
