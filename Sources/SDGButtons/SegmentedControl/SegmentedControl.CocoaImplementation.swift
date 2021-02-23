/*
 SegmentedControl.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
  import SDGLogic
  import SDGText
  import SDGLocalization

  import SDGInterface

  extension SegmentedControl {

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
          target = self
          action = #selector(Self.triggerAction)
        #else
          addTarget(self, action: #selector(Self.triggerAction), for: .valueChanged)
        #endif

        #if canImport(AppKit)
          (cell as? NSSegmentedCell)?.segmentStyle = .rounded
        #endif

        #if canImport(AppKit)
          (cell as? NSSegmentedCell)?.trackingMode = .selectOne
        #else
          isMomentary = false
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

      // MARK: - Action

      @objc private func triggerAction() {
        #if canImport(AppKit)
          let newIndex = selectedTag()
        #else
          let newIndex = selectedSegmentIndex
        #endif
        if let option = Option.allCases.enumerated().first(where: { indexed in
          indexed.offset == newIndex
        })?.element,
          option ≠ selection.value
        {
          selection.value = option
        }
      }

      // MARK: - Updating

      private func updateLocalization() {
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
              setImage(image.cocoaImage()?.native, forSegment: index)
              setImageScaling(.scaleProportionallyDown, forSegment: index)
            #else
              setImage(image.cocoaImage()?.native, forSegmentAt: index)
            #endif
          }
        }
      }

      private func updateSelection() {
        if let index = Option.allCases.enumerated().first(where: { indexed in
          indexed.element == selection.value
        })?.offset {
          #if canImport(AppKit)
            _ = selectSegment(withTag: index)
          #elseif canImport(UIKit)
            selectedSegmentIndex = index
          #endif
        }
      }

      #if canImport(AppKit)
        // MARK: - NSSegmentedControl

        internal override func selectSegment(withTag tag: Int) -> Bool {
          let result = super.selectSegment(withTag: tag)
          triggerAction()
          return result
        }
      #elseif canImport(UIKit)
        internal override var selectedSegmentIndex: Int {
          didSet {
            triggerAction()
          }
        }
      #endif

      // MARK: - SharedValueObserver

      private var localizationIdentifier: String { "localization" }
      private var selectionIdentifier: String { "selection" }
      internal func valueChanged(for identifier: String) {
        switch identifier {
        case localizationIdentifier:
          updateLocalization()
        case selectionIdentifier:
          updateSelection()
        default:  // @exempt(from: tests)
          break  // @exempt(from: tests)
        }
      }
    }
  }
#endif
