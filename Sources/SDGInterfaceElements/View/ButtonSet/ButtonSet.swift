/*
 ButtonSet.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceLocalizations

/// A group of related buttons.
public class ButtonSet<L>: NSSegmentedControl, SharedValueObserver where L : Localization {

    // MARK: - Initialization

    /// Creates a button.
    public init(segments: [(label: Shared<UserFacing<SegmentLabel, L>>, action: Selector, target: Any?)]) {

        labels = segments.map { $0.label }
        actions = segments.map { ($0.action, $0.target) }

        super.init(frame: CGRect.zero)

        (cell as? NSSegmentedCell)?.segmentStyle = .rounded
        (cell as? NSSegmentedCell)?.trackingMode = .momentary
        font = Font.forLabels

        segmentCount = segments.count
        for index in segments.indices {
            (cell as? NSSegmentedCell)?.setTag(index, forSegment: index)
        }
        (cell as? NSSegmentedCell)?.action = #selector(ButtonSet.performAction(_:))
        (cell as? NSSegmentedCell)?.target = self

        for label in labels {
            label.register(observer: self)
        }
        LocalizationSetting.current.register(observer: self)
    }

    @available(*, unavailable) public required init?(coder: NSCoder) { // @exempt(from: unicode)
        codingNotSupported(forType: UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "ButtonSet"
            }
        }))
        return nil
    }

    // MARK: - Properties

    private let labels: [Shared<UserFacing<SegmentLabel, L>>]
    private let actions: [(action: Selector, target: Any?)]

    // MARK: - Action

    @objc private func performAction(_ sender: Any?) {
        let action = actions[selectedSegment]
        NSApplication.shared.sendAction(action.action, to: action.target, from: sender)
    }

    // MARK: - SharedValueObserver

    public func valueChanged(for identifier: String) {
        for index in labels.indices {
            switch labels[index].value.resolved() {
            case .text(let label):
                setLabel(String(label), forSegment: index)
            case .image(let image):
                setImage(image, forSegment: index)
                setImageScaling(.scaleProportionallyDown, forSegment: index)
            }
        }
    }
}
