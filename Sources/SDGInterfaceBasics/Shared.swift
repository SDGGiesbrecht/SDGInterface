/*
 Shared.swift

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

import SDGControlFlow

extension Shared {

  #if canImport(SwiftUI)
    @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
    public var binding: SwiftUI.Binding<Value> {
      return SwiftUI.Binding(get: { self.value }, set: { self.value = $0 })
    }
  #endif
}
