/*
 AnyNativeView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import SDGLogic

public final class AnyNativeView: View {

    // MARK: - Initialization

    /// Creates an empty native view.
    public convenience init() {
        #if canImport(AppKit)
        self.init(NSView())
        #elseif canImport(UIKit)
        self.init(UIView())
        #endif
    }

    #if canImport(AppKit)
    // @documentation(AnyNativeView.init(_:))
    /// Wraps a native view.
    ///
    /// - Parameters:
    ///     - native: The native view.
    public init(_ native: NSView) {
        self.native = native
    }
    #elseif canImport(UIKit)
    // #documentation(AnyNativeView.init(_:))
    /// Wraps a native view.
    ///
    /// - Parameters:
    ///     - native: The native view.
    public init(_ native: UIView) {
        self.native = native
    }
    #endif

    // MARK: - View

    #if canImport(AppKit)
    public var native: NSView
    #elseif canImport(UIKit)
    public var native: UIView
    #endif

    // MARK: - Layout Constraints

    private func addSubviewIfNecessary(_ subview: View) {
        subview.native.translatesAutoresizingMaskIntoConstraints = false

        if ¬native.subviews.contains(subview.native) {
            native.addSubview(subview.native)
        }
    }

    // MARK: - Subview Sequences

    /// Arranges a subview to fill the view.
    ///
    /// The subview will be automatically added if it has not been added already.
    ///
    /// - Parameters:
    ///     - subview: The subview with which to fill the view.
    ///     - margin: The size of the margins.
    public func fill(with subview: View, margin: Spacing = .automatic) {
        fill(with: subview, on: .horizontal, margin: margin)
        fill(with: subview, on: .vertical, margin: margin)
    }

    /// Arranges a subview to fill the view along one axis.
    ///
    /// The subview will be automatically added if it has not been added already.
    ///
    /// - Parameters:
    ///     - subview: The subview with which to fill the view.
    ///     - axis: The axis to fill.
    ///     - margin: The size of the margins.
    public func fill(with subview: View, on axis: Axis, margin: Spacing = .automatic) {
        fill(with: subview, on: axis, leadingMargin: margin, trailingMargin: margin)
    }

    /// Arranges a subview to fill the view on one axis with differing margins.
    ///
    /// The subview will be automatically added if it has not been added already.
    ///
    /// - Parameters:
    ///     - subview: The subview with which to fill the view.
    ///     - axis: The axis to fill.
    ///     - leadingMargin: The size of the leading margin.
    ///     - trailingMargin: The size of the trailing margin.
    public func fill(with subview: View, on axis: Axis, leadingMargin: Spacing, trailingMargin: Spacing) {
        position(
            subviews: [subview],
            inSequenceAlong: axis,
            padding: .automatic,
            leadingMargin: leadingMargin,
            trailingMargin: trailingMargin)
    }

    /// Arranges subviews along an axis.
    ///
    /// The subview will be automatically added if they have not been added already.
    ///
    /// - Precondition: A least one view must be specified.
    ///
    /// - Precondition: The padding between views must not be unspecified if there is more than one view.
    ///
    /// - Parameters:
    ///     - subviews: The views to position in sequence.
    ///     - axis: The axis along which to position the views.
    ///     - padding: The size of the padding between views.
    ///     - margin: The size of the margins.
    public func position(
        subviews: [View],
        inSequenceAlong axis: Axis,
        padding: Spacing = .automatic,
        margin: Spacing = .automatic) {

        position(
            subviews: subviews,
            inSequenceAlong: axis,
            padding: padding,
            leadingMargin: margin,
            trailingMargin: margin)
    }

    /// Arranges subviews along an axis.
    ///
    /// The subviews will be automatically added if they have not been added already.
    ///
    /// - Precondition: A least one view must be specified.
    ///
    /// - Precondition: The padding between views must not be unspecified if there is more than one view.
    ///
    /// - Parameters:
    ///     - subviews: The views to position in sequence.
    ///     - axis: The axis along which to position the views.
    ///     - padding: The size of the padding between views.
    ///     - leadingMargin: The size of the leading margin.
    ///     - trailingMargin: The size of the trailing margin.
    public func position(
        subviews: [View],
        inSequenceAlong axis: Axis,
        padding: Spacing = .automatic,
        leadingMargin: Spacing,
        trailingMargin: Spacing) {

        for view in subviews {
            addSubviewIfNecessary(view)
        }

        var viewList = String()
        #if canImport(AppKit)
        var viewDictionary = [String: NSView]()
        #elseif canImport(UIKit)
        var viewDictionary = [String: UIView]()
        #endif
        for index in subviews.indices {
            if index > 0 {
                viewList += padding.string
            }
            viewList += "[v\(index)]"
            viewDictionary["v\(index)"] = subviews[index].native
        }

        let leadingMarginString = "|\(leadingMargin.string)"
        let trailingMarginString = "\(trailingMargin.string)|"

        let visualFormat = "\(axis.string)\(leadingMarginString)\(viewList)\(trailingMarginString)"
        let constraints = NSLayoutConstraint.constraints(
            withVisualFormat: visualFormat,
            options: [],
            metrics: nil,
            views: viewDictionary)
        native.addConstraints(constraints)
    }

    // MARK: - Size Limits

    /// Sets the minimum size for the view along a given axis.
    ///
    /// - Parameters:
    ///     - size: The minimum size.
    ///     - axis: The axis to constrain.
    public func setMinimumSize(size: CGFloat, axis: Axis) {
        let format = "\(axis.string)[view(\u{3E}=\(size))]"
        let constraints = NSLayoutConstraint.constraints(
            withVisualFormat: format,
            options: [],
            metrics: nil,
            views: ["view": self.native])
        native.addConstraints(constraints)
    }

    // MARK: - Centring Subviews

    /// Centres a subview.
    ///
    /// The subview will be automatically added if it has not been added already.
    ///
    /// - Parameters:
    ///     - subview: The subview to centre.
    public func centre(subview: View) {
        centre(subview: subview, on: .horizontal)
        centre(subview: subview, on: .vertical)
    }

    /// Centres a subview on an axis.
    ///
    /// The subview will be automatically added if it has not been added already.
    ///
    /// - Parameters:
    ///     - subview: The subview to centre.
    ///     - axis: An axis along which to centre the subview.
    public func centre(subview: View, on axis: Axis) {

        addSubviewIfNecessary(subview)

        let attribute: NSLayoutConstraint.Attribute
        switch axis {
        case .horizontal:
            attribute = .centerX
        case .vertical:
            attribute = .centerY
        }

        let constraint = NSLayoutConstraint(
            item: subview,
            attribute: attribute,
            relatedBy: .equal,
            toItem: self.native,
            attribute: attribute,
            multiplier: 1,
            constant: 0)
        native.addConstraint(constraint)
    }

    // MARK: - Subview Proportions

    /// Makes the width or height of subviews equal.
    ///
    /// The subviews will be automatically added if they have not been added already.
    ///
    /// - Parameters:
    ///     - subviews: The subviews to make the same size.
    ///     - axis: An axis along which to resize the subviews.
    public func equalizeSize(amongSubviews subviews: [View], on axis: Axis) {
        let attribute: NSLayoutConstraint.Attribute
        switch axis {
        case .horizontal:
            attribute = .width
        case .vertical:
            attribute = .height
        }
        equalize(attribute, amongSubviews: subviews)
    }

    /// Makes the length or width of subviews a fraction of the same attribute on the superview.
    ///
    /// The subviews will be automatically added if they have not been added already.
    ///
    /// - Parameters:
    ///     - subviews: The subviews to resize.
    ///     - coefficient: The size ratio.
    ///     - axis: An axis along which to resize the subviews.
    public func lockSizeRatio(toSubviews subviews: [View], coefficient: CGFloat, axis: Axis) {
        let attribute: NSLayoutConstraint.Attribute
        switch axis {
        case .horizontal:
            attribute = .width
        case .vertical:
            attribute = .height
        }
        lock(attribute, ratioToSubviews: subviews, coefficient: coefficient)
    }

    // MARK: - Subview Alignment

    /// Aligns subviews according to their centre.
    ///
    /// The subviews will be automatically added if they have not been added already.
    ///
    /// - Parameters:
    ///     - subviews: The subviews to align.
    ///     - axis: An axis along which to align the subviews.
    public func alignCentres(ofSubviews subviews: [View], on axis: Axis) {
        let attribute: NSLayoutConstraint.Attribute
        switch axis {
        case .horizontal:
            attribute = .centerX
        case .vertical:
            attribute = .centerY
        }
        equalize(attribute, amongSubviews: subviews)
    }

    /// Aligns subviews according to their baseline.
    ///
    /// The subviews will be automatically added if they have not been added already.
    ///
    /// - Parameters:
    ///     - subviews: The subviews to align.
    public func alignLastBaselines(ofSubviews subviews: [View]) {
        equalize(.lastBaseline, amongSubviews: subviews)
    }

    // MARK: - Aspect Ratio

    /// Locks the aspect ratio of the view.
    ///
    /// - Parameters:
    ///     - aspectRatio: The aspect ratio. (*width* ∶ *height*)
    public func lockAspectRatio(to aspectRatio: CGFloat) {
        let constraint = NSLayoutConstraint(
            item: self.native,
            attribute: .width,
            relatedBy: .equal,
            toItem: self.native,
            attribute: .height,
            multiplier: aspectRatio,
            constant: 0)
        native.addConstraint(constraint)
    }

    // MARK: - Abstract

    /// Makes an attribute of subviews equal.
    ///
    /// The subviews will be automatically added if they have not been added already.
    ///
    /// - Parameters:
    ///     - attribute: The attribute to equalize.
    ///     - subviews: The subviews on whose attributes should be equalized.
    public func equalize(_ attribute: NSLayoutConstraint.Attribute, amongSubviews subviews: [View]) {
        for view in subviews {
            addSubviewIfNecessary(view)
        }

        for viewIndex in subviews.indices {
            let constraint = NSLayoutConstraint(
                item: subviews[0].native,
                attribute: attribute,
                relatedBy: .equal,
                toItem: subviews[viewIndex].native,
                attribute: attribute,
                multiplier: 1,
                constant: 0)
            native.addConstraint(constraint)
        }
    }

    /// Makes an attribute of subviews a fraction of the same attribute on the superview.
    ///
    /// The subviews will be automatically added if they have not been added already.
    ///
    /// - Parameters:
    ///     - attribute: The attribute to lock.
    ///     - subviews: The subviews on whose attributes should be locked.
    ///     - coefficient: The ratio.
    public func lock(
        _ attribute: NSLayoutConstraint.Attribute,
        ratioToSubviews subviews: [View],
        coefficient: CGFloat) {
        for view in subviews {
            addSubviewIfNecessary(view)
            let constraint = NSLayoutConstraint(
                item: self.native,
                attribute: attribute,
                relatedBy: .equal,
                toItem: view.native,
                attribute: attribute,
                multiplier: coefficient,
                constant: 0)
            native.addConstraint(constraint)
        }
    }
}
