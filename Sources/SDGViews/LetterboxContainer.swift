
#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

import SDGInterfaceBasics

#if canImport(AppKit)
internal typealias LetterboxContainerSuperClass = NSView
#elseif canImport(UIKit)
internal typealias LetterboxContainerSuperClass = UIView
#endif
internal class LetterboxContainer : LetterboxContainerSuperClass {

    // MARK: - Properties

    internal var colour: Colour?

    // MARK: - LetterboxContainerSuperClass

    internal override func draw(_ dirtyRect: CGRect) { // @exempt(from: tests) Crashes without active interface.
        if let colour = self.colour {
            #if canImport(AppKit)
            let native = colour.nsColor
            #elseif canImport(UIKit)
            let native = colour.uiColor
            #endif
            native.setFill()
            if colour.opacity < 1 {
                #if canImport(UIKit)
                UIRectFillUsingBlendMode(dirtyRect, .normal)
                #else
                dirtyRect.fill(using: .sourceOver)
                #endif
            } else {
                #if canImport(UIKit)
                UIRectFill(dirtyRect)
                #else
                dirtyRect.fill()
                #endif
            }
        }
        super.draw(dirtyRect)
    }
}
#endif
