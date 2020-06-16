/*
 Image.SwiftUIImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(watchOS 6, *)
  extension Image {

    #warning("Does this need to exist separately?")
    @available(macOS 10.15, tvOS 13, iOS 13, *)
    internal struct SwiftUIImplementation: SwiftUI.View {

      // MARK: - Properties

      internal let image: Image

      // MARK: - View

      internal var body: some SwiftUI.View {
        return image.swiftUIImage()
      }
    }
  }
#endif
