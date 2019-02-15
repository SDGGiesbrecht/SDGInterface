/*
 View.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SDGInterfaceLocalizations

#if canImport(AppKit)
// @documentation(View)
/// An alias for `NSView` or `UIView`.
public typealias View = NSView
#elseif canImport(UIKit)
// #documentation(View)
/// An alias for `NSView` or `UIView`.
public typealias View = UIView
#endif

extension View {

    private func addSubviewIfNecessary(_ subview: View) {
        subview.translatesAutoresizingMaskIntoConstraints = false

        if !subviews.contains(subview) {
            addSubview(subview)
        }
    }

    // MARK: - Layout Constraints

    // MARK: - Size Limits

    /// Sets the minimum size for the view along a given axis.
    public func setMinimumSize(size: Double, axis: Axis) {
        let format = "\(axis.string)[view(>=\(size))]"
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: ["view": self])
        addConstraints(constraints)
    }

    // MARK: - Subview Sequences

    /// Arranges a subview to fill the view. The subview will be automatically added if it has not been added already.
    public func fill(with subview: View, margin: Margin = .system) {
        fill(with: subview, on: .horizontal, margin: margin)
        fill(with: subview, on: .vertical, margin: margin)
    }

    /// Arranges a subview to fill the view along one axis. The subview will be automatically added if it has not been added already.
    public func fill(with subview: View, on axis: Axis, margin: Margin = .system) {
        fill(with: subview, on: axis, leadingMargin: margin, trailingMargin: margin)
    }

    /// Arranges a subview to fill the view on one axis with differing margins. The subview will be automatically added if it has not been added already.
    public func fill(with subview: View, on axis: Axis, leadingMargin: Margin, trailingMargin: Margin) {
        position(views: [subview], inSequenceAlong: axis, padding: .system, leadingMargin: leadingMargin, trailingMargin: trailingMargin)
    }

    /// Arranges subviews along an axis. The subview will be automatically added if they have not been added already.
    ///
    /// - Precondition: A least one view must be specified.
    ///
    /// - Precondition: The padding between views must not be unspecified if there is more than one view.
    public func position(views: [View], inSequenceAlong axis: Axis, padding: Margin = .system, margin: Margin = .system) {
        position(views: views, inSequenceAlong: axis, padding: padding, leadingMargin: margin, trailingMargin: margin)
    }

    /// Arranges subviews along an axis. The subviews will be automatically added if they have not been added already.
    ///
    /// - Precondition: A least one view must be specified.
    ///
    /// - Precondition: The padding between views must not be unspecified if there is more than one view.
    ///
    /// - Parameters:
    ///     - views: The views to position in sequence.
    ///     - axis: The axis along which to position the views.
    ///     - padding: The size of the padding between views.
    ///     - leadingMargin: The size of the leading margin.
    ///     - trailingMargin: The size of the trailing margin.
    public func position(views: [View], inSequenceAlong axis: Axis, padding: Margin = .system, leadingMargin: Margin, trailingMargin: Margin) {

        for view in views {
            addSubviewIfNecessary(view)
        }

        assert(views.count > 0, UserFacing<StrictString, APILocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Attempt made to position 0 views in sequence."
            }
        }))

        var viewList = String()
        var viewDictionary = [String: View]()
        for index in views.indices {
            if index > 0 {
                guard let paddingString = padding.string else {
                    preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                        switch localization {
                        case .englishCanada:
                            return "No padding specified."
                        }
                    }))
                }
                viewList += paddingString
            }
            viewList += "[v\(index)]"
            viewDictionary["v\(index)"] = views[index]
        }

        var leadingMarginString = ""
        if let string = leadingMargin.string {
            leadingMarginString = "|\(string)"
        }

        var trailingMarginString = ""
        if let string = trailingMargin.string {
            trailingMarginString = "\(string)|"
        }

        let visualFormat = "\(axis.string)\(leadingMarginString)\(viewList)\(trailingMarginString)"
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: [], metrics: nil, views: viewDictionary)
        addConstraints(constraints)
    }
}
