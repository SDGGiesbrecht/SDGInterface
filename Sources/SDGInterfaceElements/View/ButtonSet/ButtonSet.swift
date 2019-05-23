/*
 ButtonSet.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(watchOS)

import SDGCollections

import SDGInterfaceLocalizations

/// A group of related buttons.
public class ButtonSet<L> : NSSegmentedControl, SharedValueObserver where L : Localization {

    // MARK: - Initialization

    /// Creates a button set.
    ///
    /// - Parameters:
    ///     - segments: The segments of the button set.
    ///     - label: The label of the segment.
    ///     - action: An action for the segment.
    ///     - target: A target for the segment.
    public init(segments: [(label: Shared<UserFacing<ButtonSetSegmentLabel, L>>, action: Selector?, target: Any?)]) {

        labels = segments.map { $0.label }
        actions = segments.map { ($0.action, $0.target) }

        super.init(frame: CGRect.zero)

        #if canImport(AppKit)
        (cell as? NSSegmentedCell)?.segmentStyle = .rounded
        #endif

        #if canImport(AppKit)
        (cell as? NSSegmentedCell)?.trackingMode = .momentary
        #else
        isMomentary = true
        #endif

        #if canImport(AppKit)
        font = Font.forLabels
        #else
        var attributes = titleTextAttributes(for: .normal) ?? [:]
        attributes[.font] = Font.forLabels
        setTitleTextAttributes(attributes, for: .normal)
        #endif

        #if canImport(AppKit)
        segmentCount = segments.count
        #endif
        for index in segments.indices {
            #if canImport(AppKit)
            (cell as? NSSegmentedCell)?.setTag(index, forSegment: index)
            #else
            let segment = segments[index]
            insertSegment(withTitle: nil, at: index, animated: false)
            if let selector = segment.action {
                addTarget(segment.target, action: selector, for: .primaryActionTriggered)
            }
            #endif
        }
        #if canImport(AppKit)
        (cell as? NSSegmentedCell)?.action = #selector(ButtonSet.performAction(_:))
        (cell as? NSSegmentedCell)?.target = self
        #endif

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

    private let labels: [Shared<UserFacing<ButtonSetSegmentLabel, L>>]
    private let actions: [(action: Selector?, target: Any?)]

    // MARK: - Action

    #if canImport(AppKit)
    @objc private func performAction(_ sender: Any?) {
        // @exempt(from: tests) Impossible to select a segment without being displayed.
        if selectedSegment ∈ actions.indices {
            let action = actions[selectedSegment]
            if let selector = action.action {
                NSApplication.shared.sendAction(selector, to: action.target, from: sender)
            }
        }
    }
    #endif

    // MARK: - SharedValueObserver

    public func valueChanged(for identifier: String) {
        for index in labels.indices {
            switch labels[index].value.resolved() {
            case .text(let label):
                #if canImport(AppKit)
                setLabel(String(label), forSegment: index)
                #else
                setTitle(String(label), forSegmentAt: index)
                #endif
            case .image(let image):
                #if canImport(AppKit)
                setImage(image, forSegment: index)
                setImageScaling(.scaleProportionallyDown, forSegment: index)
                #else
                setImage(image, forSegmentAt: index)
                #endif
            }
        }
    }
}

#endif
