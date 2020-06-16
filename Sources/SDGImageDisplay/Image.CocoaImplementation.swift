/*
 Image.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  extension Image {
    
    #warning("Does this need to exist separately?")
    #if canImport(AppKit)
      internal typealias Superclass = NSImageView
    #else
      internal typealias Superclass = UIImageView
    #endif
    internal class CocoaImplementation: Superclass {

      // MARK: - Initialization

      internal init(image: Image) {
        super.init(frame: .zero)
        self.image = image.cocoaImage

        #if canImport(AppKit)
          setContentCompressionResistancePriority(
            .windowSizeStayPut,
            for: .horizontal
          )
          setContentCompressionResistancePriority(
            .windowSizeStayPut,
            for: .vertical
          )
        #endif
      }

      internal required init?(coder: NSCoder) {  // @exempt(from: tests)
        return nil
      }
    }
  }
#endif
