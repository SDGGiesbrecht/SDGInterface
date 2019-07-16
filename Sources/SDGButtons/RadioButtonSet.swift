/*
 RadioButtons.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

/// A set of radio buttons.
public class RadioButtonSet<Option, L> : SpecificView where Option : CaseIterable, L : Localization, Option.AllCases == Array<Option> {

    // MARK: - Initialization

    public init(labels: @escaping (Option) -> UserFacing<ButtonLabel, L>) {
        self.labels = labels
        defer {
            LocalizationSetting.current.register(observer: bindingObserver)
        }

        #if canImport(AppKit)
        specificNative = NSSegmentedControl()
        #elseif canImport(UIKit)
        specificNative = UISegmentedControl()
        #endif

        #if canImport(AppKit)
        (specificNative.cell as? NSSegmentedCell)?.segmentStyle = .rounded
        #endif

        #if canImport(AppKit)
        (specificNative.cell as? NSSegmentedCell)?.trackingMode = .momentary
        #else
        specificNative.isMomentary = true
        #endif

        #if canImport(AppKit)
        specificNative.font = Font.forLabels.native
        #else
        var attributes = titleTextAttributes(for: .normal) ?? [:]
        attributes.font = Font.forLabels
        specificNative.setTitleTextAttributes(attributes, for: .normal)
        #endif

        #if canImport(AppKit)
        specificNative.segmentCount = Option.allCases.count
        #endif
        for index in Option.allCases.indices {
            #if canImport(AppKit)
            (specificNative.cell as? NSSegmentedCell)?.setTag(index, forSegment: index)
            #else
            let segment = segments[index]
            insertSegment(withTitle: nil, at: index, animated: false)
            if let selector = segment.action {
                addTarget(segment.target, action: selector, for: .primaryActionTriggered)
            }
            #endif
        }
    }

    // MARK: - Properties

    private let bindingObserver = RadioBindingObserver()

    /// The labels.
    public let labels: (Option) -> UserFacing<ButtonLabel, L>

    // MARK: - Refreshing

    public func _refreshBindings() {
        let cases = Option.allCases
        for index in cases.indices {
            switch labels(cases[index]).resolved() {
            case .text(let label):
                #if canImport(AppKit)
                specificNative.setLabel(String(label), forSegment: index)
                #else
                specificNative.setTitle(String(label), forSegmentAt: index)
                #endif
            case .symbol(let image):
                #if canImport(AppKit)
                specificNative.setImage(image.native, forSegment: index)
                specificNative.setImageScaling(.scaleProportionallyDown, forSegment: index)
                #else
                specificNative.setImage(image.native, forSegmentAt: index)
                #endif
            }
        }
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
    public let specificNative: NSSegmentedControl
    #elseif canImport(UIKit)
    public let specificNative: UISegmentedControl
    #endif
}
#endif
