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
      let constructedBar = progressBar ?? ProgressBar()
      self.progressBar = constructedBar
      container = AnyCocoaView()
      container.fill(with: label, on: .horizontal, margin: .specific(0))
      container.fill(with: constructedBar, on: .horizontal, margin: .specific(0))
      container.position(
        subviews: [label, constructedBar],
        inSequenceAlong: .vertical,
        padding: .automatic,
        margin: .specific(0)
      )
    }

    // MARK: - Properties

    private let container: AnyCocoaView

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
