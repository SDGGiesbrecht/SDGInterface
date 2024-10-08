/*
 CocoaView.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

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
      /// The native type of the Cocoa window, which is `NSWindow` on macOS and `UIWindow` on tvOS and iOS.
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

    /// Calculates the view’s natural size according to its contents.
    public func intrinsicSize() -> Size {
      return Size(native.intrinsicContentSize)
    }

    // MARK: - Layout Constraints

    /// Adds the subview to this view unless has already been added.
    ///
    /// - Parameters:
    ///   - subview: The new subview.
    internal func addSubviewIfNecessary(_ subview: CocoaView) {
      subview.disableAutoresizingMask()

      if ¬native.subviews.contains(subview.native) {
        native.addSubview(subview.native)
      }
    }

    /// Disables constraints inherited from the autoresizing mask.
    public func disableAutoresizingMask() {
      native.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Size

    /// Sets the aspect ratio of the view.
    ///
    /// - Parameters:
    ///   - aspectRatio: The aspect ratio.
    public func lock(aspectRatio: Double) {
      constrain((self, .width), toBe: .equal, (self, .height), times: aspectRatio)
    }

    // MARK: - Subview Arrangement

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

    // MARK: - Subview Alignment

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

      constrain((subview, attribute), toBe: .equal, (self, attribute))
    }

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
        constrain((subviews[0], attribute), toBe: .equal, (subviews[viewIndex], attribute))
      }
    }

    /// Applies an intrinsic layout constraint.
    ///
    /// - Parameters:
    ///   - attribute: The attribute to constrain.
    ///   - relation: The relationship between the attribute and the constant.
    ///   - constant: A constant.
    ///   - priority: The priority of the constraint.
    public func constrain(
      _ attribute: NSLayoutConstraint.Attribute,
      toBe relation: NSLayoutConstraint.Relation,
      _ constant: Double,
      priority: LayoutConstraintPriority = .required
    ) {
      let constraint = NSLayoutConstraint(
        item: native,
        attribute: attribute,
        relatedBy: relation,
        toItem: nil,
        attribute: .notAnAttribute,
        multiplier: 1,
        constant: CGFloat(constant)
      )
      constraint.priority = LayoutConstraintPriority.NativeType(priority)
      native.addConstraint(constraint)
    }

    /// Applies a layout constraint.
    ///
    /// - Parameters:
    ///   - property1: The first property of the view hierarchy.
    ///   - relation: The relationship between the two attributes.
    ///   - property2: The second property of the view hierarchy.
    ///   - coefficient: A coefficient by which to multiply the second attribute.
    ///   - constant: A constant to add to the second attribute.
    ///   - priority: The priority of the constraint.
    public func constrain(
      _ property1: (view1: CocoaView, attribute1: NSLayoutConstraint.Attribute),
      toBe relation: NSLayoutConstraint.Relation,
      _ property2: (view2: CocoaView, attribute2: NSLayoutConstraint.Attribute),
      times coefficient: Double = 1,
      plus constant: Double = 0,
      priority: LayoutConstraintPriority = .required
    ) {
      let constraint = NSLayoutConstraint(
        item: property1.view1.native,
        attribute: property1.attribute1,
        relatedBy: relation,
        toItem: property2.view2.native,
        attribute: property2.attribute2,
        multiplier: CGFloat(coefficient),
        constant: CGFloat(constant)
      )
      constraint.priority = LayoutConstraintPriority.NativeType(priority)
      native.addConstraint(constraint)
    }

    /// Applies a layout constraint to several subviews at once.
    ///
    /// - Parameters:
    ///   - attribute: The attribute of the main view.
    ///   - relation: The relationship between the two attributes.
    ///   - subviewAttribute: The property of the subviews.
    ///   - subviews: The subviews.
    ///   - coefficient: A coefficient by which to multiply the subview attribute.
    ///   - constant: A constant to add to the subview attribute.
    public func constrain(
      _ attribute: NSLayoutConstraint.Attribute,
      toBe relation: NSLayoutConstraint.Relation,
      _ subviewAttribute: NSLayoutConstraint.Attribute,
      ofSubviews subviews: [CocoaView],
      times coefficient: Double = 1,
      plus constant: Double = 0
    ) {
      for view in subviews {
        addSubviewIfNecessary(view)
        constrain(
          (self, attribute),
          toBe: relation,
          (view, attribute),
          times: coefficient,
          plus: constant
        )
      }
    }

    // MARK: - Pop‐Overs

    /// Displays a pop‐over related to this view.
    ///
    /// - Parameters:
    ///   - content: The content of the pop‐over.
    ///   - attachmentAnchor: The portion of the view the pop‐over is related to.
    ///   - arrowEdge: The edge of the anchor that the pop‐over should appear from.
    public func displayPopOver<Content>(
      _ content: Content,
      attachmentAnchor: AttachmentAnchor = .rectangle(.bounds),
      arrowEdge: SDGInterface.Edge = .top
    ) where Content: LegacyView {

      let popOverView = CocoaView.PopOverView(content)

      let attachmentRectangle: CGRect
      switch attachmentAnchor {
      case .point(let point):
        attachmentRectangle = CGRect(origin: CGPoint(point), size: CGSize(width: 0, height: 0))
      case .rectangle(let rectangle):
        switch rectangle {
        case .bounds:
          attachmentRectangle = self.native.frame
        case .rectangle(let rectangle):
          attachmentRectangle = CGRect(rectangle)
        }
      }

      #if canImport(UIKit)
        let controller = UIViewController()
        #if os(tvOS)
          controller.modalPresentationStyle = .overCurrentContext
        #else
          controller.modalPresentationStyle = .popover
        #endif
        controller.view = popOverView

        let popOver = controller.popoverPresentationController
        #if !os(tvOS)
          popOver?.delegate = CocoaView.PopOverDelegate.delegate
        #endif
        popOver?.sourceView = self.native
        popOver?.sourceRect = attachmentRectangle
        popOver?.permittedArrowDirections = UIPopoverArrowDirection(arrowEdge)

        self.native.controller?.present(controller, animated: true, completion: nil)
      #else
        let controller = NSViewController()
        controller.view = popOverView

        let popOver = NSPopover()
        popOver.contentViewController = controller
        popOver.behavior = .transient
        popOver.show(
          relativeTo: attachmentRectangle,
          of: self.native,
          preferredEdge: NSRectEdge(arrowEdge)
        )
      #endif
    }

    // MARK: - CocoaViewImplementation

    public func cocoa() -> CocoaView {
      return self
    }
  }
#endif
