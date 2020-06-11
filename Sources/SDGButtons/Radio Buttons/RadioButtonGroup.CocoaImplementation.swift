/*
 RadioButtonGroup.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGControlFlow
  import SDGText
  import SDGLocalization

  extension RadioButtonGroup {

    #if canImport(AppKit)
      internal typealias Superclass = NSSegmentedControl
    #else
      internal typealias Superclass = UISegmentedControl
    #endif
    internal final class CocoaImplementation: Superclass, SharedValueObserver {

      // MARK: - Initialization

      internal init(
        labels: @escaping (_ option: Option) -> UserFacing<ButtonLabel, L>,
        selection: Shared<Option>
      ) {

        self.labels = labels
        defer {
          LocalizationSetting.current.register(observer: self, identifier: localizationIdentifier)
        }

        self.selection = selection
        defer {
          selection.register(observer: self, identifier: selectionIdentifier)
        }

        super.init(frame: .zero)

        #if canImport(AppKit)
          (cell as? NSSegmentedCell)?.segmentStyle = .rounded
        #endif

        #if canImport(AppKit)
          (cell as? NSSegmentedCell)?.trackingMode = .momentary
        #else
          isMomentary = true
        #endif

        #if canImport(AppKit)
          font = NSFont.from(Font.forLabels)
        #else
          var attributes = titleTextAttributes(for: .normal) ?? [:]
          attributes.font = Font.forLabels
          setTitleTextAttributes(attributes, for: .normal)
        #endif

        #if canImport(AppKit)
          segmentCount = Option.allCases.count
        #endif
        for (index, _) in Option.allCases.enumerated() {
          #if canImport(AppKit)
            (cell as? NSSegmentedCell)?.setTag(index, forSegment: index)
          #else
            insertSegment(withTitle: nil, at: index, animated: false)
          #endif
        }
      }

      internal required init?(coder decoder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let labels: (_ option: Option) -> UserFacing<ButtonLabel, L>
      private let selection: Shared<Option>

      // MARK: - SharedValueObserver

      private var localizationIdentifier: String { "localization" }
      private var selectionIdentifier: String { "selection" }
      internal func valueChanged(for identifier: String) {
        switch identifier {
        case localizationIdentifier:
          for (index, option) in Option.allCases.enumerated() {
            switch labels(option).resolved() {
            case .text(let label):
              #if canImport(AppKit)
                setLabel(String(label), forSegment: index)
              #else
                setTitle(String(label), forSegmentAt: index)
              #endif
            case .symbol(let image):
              #if canImport(AppKit)
                setImage(image.cocoa, forSegment: index)
                setImageScaling(.scaleProportionallyDown, forSegment: index)
              #else
                setImage(image.cocoa, forSegmentAt: index)
              #endif
            }
          }
        case selectionIdentifier:
          if let index = Option.allCases.enumerated().first(where: { indexed in
            indexed.element == self.selection.value
          })?.offset {
            #if canImport(AppKit)
              (cell as? NSSegmentedCell)?.selectSegment(withTag: index)
            #else
              insertSegment(withTitle: nil, at: index, animated: false)
            #endif
          }
        default:
          break
        }
      }
    }
  }
#endif
