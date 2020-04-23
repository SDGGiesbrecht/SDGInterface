/*
 RadioButtonSet.swift

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

  import SDGViews
  import SDGTextDisplay

  /// A set of radio buttons.
  public class RadioButtonSet<Option, L>: AnyRadioButtonSet, CocoaViewImplementation, View
  where Option: CaseIterable, L: Localization, Option.AllCases == [Option] {

    // MARK: - Initialization

    /// Creates a set of radio buttons.
    ///
    /// - Parameters:
    ///     - labels: A closure which generates a label from an option.
    ///     - option: The option to label.
    public init(labels: @escaping (_ option: Option) -> UserFacing<ButtonLabel, L>) {
      self.labels = labels
      defer {
        LocalizationSetting.current.register(observer: bindingObserver)
      }

      #if canImport(AppKit)
        specificCocoaView = NSSegmentedControl()
      #elseif canImport(UIKit)
        specificCocoaView = UISegmentedControl()
      #endif
      defer {
        bindingObserver.buttons = self
      }

      #if canImport(AppKit)
        (specificCocoaView.cell as? NSSegmentedCell)?.segmentStyle = .rounded
      #endif

      #if canImport(AppKit)
        (specificCocoaView.cell as? NSSegmentedCell)?.trackingMode = .momentary
      #else
        specificCocoaView.isMomentary = true
      #endif

      #if canImport(AppKit)
        specificCocoaView.font = Font.forLabels.native
      #else
        var attributes = specificCocoaView.titleTextAttributes(for: .normal) ?? [:]
        attributes.font = Font.forLabels
        specificCocoaView.setTitleTextAttributes(attributes, for: .normal)
      #endif

      #if canImport(AppKit)
        specificCocoaView.segmentCount = Option.allCases.count
      #endif
      for index in Option.allCases.indices {
        #if canImport(AppKit)
          (specificCocoaView.cell as? NSSegmentedCell)?.setTag(index, forSegment: index)
        #else
          specificCocoaView.insertSegment(withTitle: nil, at: index, animated: false)
        #endif
      }
    }

    // MARK: - Properties

    private let bindingObserver = RadioBindingObserver()

    /// The labels.
    ///
    /// - Parameters:
    ///     - option: The option to label.
    public let labels: (_ option: Option) -> UserFacing<ButtonLabel, L>

    // MARK: - Refreshing

    public func _refreshBindings() {
      let cases = Option.allCases
      for index in cases.indices {
        switch labels(cases[index]).resolved() {
        case .text(let label):
          #if canImport(AppKit)
            specificCocoaView.setLabel(String(label), forSegment: index)
          #else
            specificCocoaView.setTitle(String(label), forSegmentAt: index)
          #endif
        case .symbol(let image):
          #if canImport(AppKit)
            specificCocoaView.setImage(image.cocoa, forSegment: index)
            specificCocoaView.setImageScaling(.scaleProportionallyDown, forSegment: index)
          #else
            specificCocoaView.setImage(image.native, forSegmentAt: index)
          #endif
        }
      }
    }

    // MARK: - LegacyView

    public func cocoa() -> CocoaView {
      return CocoaView(specificCocoaView)
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
      public let specificCocoaView: NSSegmentedControl
    #elseif canImport(UIKit)
      public let specificCocoaView: UISegmentedControl
    #endif
  }
#endif
