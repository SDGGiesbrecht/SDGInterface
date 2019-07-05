/*
 RowView.swift

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

/// A row of views.
public final class RowView : SpecificView {

    // MARK: - Initialization

    /// Creates a row of views.
    public init(views: [View], spacing: Spacing = .automatic) {
        #if canImport(AppKit)
        specificNative = NSStackView()
        #elseif canImport(UIKit)
        specificNative = UIStackView()
        #endif

        self.views = views
        defer {
            viewsDidSet()
        }

        switch spacing {
        case .automatic:
            break
        case .specific(let measurement):
            specificNative.spacing = CGFloat(measurement)
        }

        specificNative.alignment = .firstBaseline
    }

    // MARK: - Properties

    public var views: [View] {
        didSet {
            viewsDidSet()
        }
    }
    private func viewsDidSet() {
        while let view = specificNative.views.first {
            specificNative.removeView(view)
        }
        for view in views {
            specificNative.addView(view.native, in: .trailing)
        }
    }

    #if canImport(AppKit)
    public let specificNative: NSStackView
    #elseif canImport(UIKit)
    public let specificNative: UIStackView
    #endif
}
#endif
