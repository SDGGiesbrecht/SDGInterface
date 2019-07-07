/*
 NSUIView.swift

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
#elseif canImport(UIKit)
import UIKit
#endif

import SDGLogic

#if canImport(AppKit)
public typealias _NSUIView = NSView
#elseif canImport(UIKit)
public typealias _NSUIView = UIView
#endif

#warning("Move to AnyNativeView?")
extension _NSUIView {

    public func _addSubviewIfNecessary(_ subview: _NSUIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false

        if ¬subviews.contains(subview) {
            addSubview(subview)
        }
    }

    public func _fill(with subview: _NSUIView, margin: Spacing = .automatic) {
        _fill(with: subview, on: .horizontal, margin: margin)
        _fill(with: subview, on: .vertical, margin: margin)
    }

    public func _fill(with subview: _NSUIView, on axis: Axis, margin: Spacing = .automatic) {
        _fill(with: subview, on: axis, leadingMargin: margin, trailingMargin: margin)
    }

    public func _fill(with subview: _NSUIView, on axis: Axis, leadingMargin: Spacing, trailingMargin: Spacing) {
        _position(subviews: [subview], inSequenceAlong: axis, padding: .automatic, leadingMargin: leadingMargin, trailingMargin: trailingMargin)
    }

    public func _position(subviews: [_NSUIView], inSequenceAlong axis: Axis, padding: Spacing = .automatic, leadingMargin: Spacing, trailingMargin: Spacing) {

        for view in subviews {
            _addSubviewIfNecessary(view)
        }

        var viewList = String()
        var viewDictionary = [String: _NSUIView]()
        for index in subviews.indices {
            if index > 0 {
                viewList += padding.string
            }
            viewList += "[v\(index)]"
            viewDictionary["v\(index)"] = subviews[index]
        }

        let leadingMarginString = "|\(leadingMargin.string)"
        let trailingMarginString = "\(trailingMargin.string)|"

        let visualFormat = "\(axis.string)\(leadingMarginString)\(viewList)\(trailingMarginString)"
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: [], metrics: nil, views: viewDictionary)
        addConstraints(constraints)
    }
}

#endif
