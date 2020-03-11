/*
 CocoaView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGLogic

  /// A Cocoa view.
  public struct CocoaView: CocoaViewImplementation {

    // MARK: - Types

    #if canImport(AppKit)
      // @documentation(CocoaView.NativeType)
      /// The native type of the Cocoa view, which is `NSView` on macOS and `UIView` on tvOS and iOS.
      public typealias NativeType = NSView
    #elseif canImport(UIKit)
      // #documentation(CocoaView.NativeType)
      /// The native type of the Cocoa view, which is `NSView` on macOS and `UIView` on tvOS and iOS.
      public typealias NativeType = UIView
    #endif

    // MARK: - Initialization

    /// Creates an empty native view.
    public init() {
      self.init(NativeType())
    }

    /// Creates an instance with a native Cocoa view.
    ///
    /// - Parameters:
    ///   - native: The native view.
    public init(_ native: NativeType) {
      self.native = native
    }

    // MARK: - Properties

    /// The native view.
    public let native: NativeType

    // MARK: - Layout Constraints

    internal func addSubviewIfNecessary(_ subview: CocoaView) {
      subview.native.translatesAutoresizingMaskIntoConstraints = false

      if ¬native.subviews.contains(subview.native) {
        native.addSubview(subview.native)
      }
    }

    // MARK: - Subview Sequences

    internal static func spacingString(for double: Double?) -> String {
      switch double {
      case .none:
        return "\u{2D}"
      case .some(let size):
        return "\u{2D}\(size)\u{2D}"
      }
    }

    /// Arranges a subview to fill the view.
    ///
    /// The subview will be automatically added if it has not been added already.
    ///
    /// - Parameters:
    ///     - subview: The subview with which to fill the view.
    ///     - margin: The size of the margins.
    public func fill(with subview: CocoaView, margin: Double? = nil) {
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
    public func fill(with subview: CocoaView, on axis: Axis, margin: Double? = nil) {
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
    public func fill(
      with subview: CocoaView,
      on axis: Axis,
      leadingMargin: Double? = nil,
      trailingMargin: Double? = nil
    ) {
      position(
        subviews: [subview],
        inSequenceAlong: axis,
        padding: nil,
        leadingMargin: leadingMargin,
        trailingMargin: trailingMargin
      )
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
      subviews: [CocoaView],
      inSequenceAlong axis: Axis,
      padding: Double? = nil,
      margin: Double? = nil
    ) {

      position(
        subviews: subviews,
        inSequenceAlong: axis,
        padding: padding,
        leadingMargin: margin,
        trailingMargin: margin
      )
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
      subviews: [CocoaView],
      inSequenceAlong axis: Axis,
      padding: Double? = nil,
      leadingMargin: Double?,
      trailingMargin: Double?
    ) {

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
          viewList += CocoaView.spacingString(for: padding)
        }
        viewList += "[v\(index)]"
        viewDictionary["v\(index)"] = subviews[index].native
      }

      let leadingMarginString = "|\(CocoaView.spacingString(for: leadingMargin))"
      let trailingMarginString = "\(CocoaView.spacingString(for: trailingMargin))|"

      let visualFormat = "\(axis.string)\(leadingMarginString)\(viewList)\(trailingMarginString)"
      let constraints = NSLayoutConstraint.constraints(
        withVisualFormat: visualFormat,
        options: [],
        metrics: nil,
        views: viewDictionary
      )
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
        views: ["view": native]
      )
      native.addConstraints(constraints)
    }

    // MARK: - Centring Subviews

    /// Centres a subview.
    ///
    /// The subview will be automatically added if it has not been added already.
    ///
    /// - Parameters:
    ///     - subview: The subview to centre.
    public func centre(subview: CocoaView) {
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
    public func centre(subview: CocoaView, on axis: Axis) {

      addSubviewIfNecessary(subview)

      let attribute: NSLayoutConstraint.Attribute
      switch axis {
      case .horizontal:
        attribute = .centerX
      case .vertical:
        attribute = .centerY
      }

      let constraint = NSLayoutConstraint(
        item: subview.native,
        attribute: attribute,
        relatedBy: .equal,
        toItem: native,
        attribute: attribute,
        multiplier: 1,
        constant: 0
      )
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
    public func equalizeSize(amongSubviews subviews: [CocoaView], on axis: Axis) {
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
    public func lockSizeRatio(toSubviews subviews: [CocoaView], coefficient: Double, axis: Axis) {
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
    public func alignCentres(ofSubviews subviews: [CocoaView], on axis: Axis) {
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
    public func alignLastBaselines(ofSubviews subviews: [CocoaView]) {
      equalize(.lastBaseline, amongSubviews: subviews)
    }

    // MARK: - Abstract

    /// Makes an attribute of subviews equal.
    ///
    /// The subviews will be automatically added if they have not been added already.
    ///
    /// - Parameters:
    ///     - attribute: The attribute to equalize.
    ///     - subviews: The subviews on whose attributes should be equalized.
    public func equalize(
      _ attribute: NSLayoutConstraint.Attribute,
      amongSubviews subviews: [CocoaView]
    ) {
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
          constant: 0
        )
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
      ratioToSubviews subviews: [CocoaView],
      coefficient: Double
    ) {
      for view in subviews {
        addSubviewIfNecessary(view)
        let constraint = NSLayoutConstraint(
          item: native,
          attribute: attribute,
          relatedBy: .equal,
          toItem: view.native,
          attribute: attribute,
          multiplier: CGFloat(coefficient),
          constant: 0
        )
        native.addConstraint(constraint)
      }
    }

    // MARK: - CocoaViewImplementation

    public func cocoa() -> CocoaView {
      return self
    }
  }
#endif
