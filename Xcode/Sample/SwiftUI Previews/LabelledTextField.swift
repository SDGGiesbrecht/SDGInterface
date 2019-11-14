/*
 LabelledTextField.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
import SwiftUI

import SDGControlFlow
import SDGViews
import SDGTextDisplay

import SDGInterfaceLocalizations

struct LabelledTextField_Previews : PreviewProvider {
    static var previews: some SwiftUI.View {
        let view = LabelledTextField<InterfaceLocalization>(labelText: .binding(Shared("Label")))
        let margin = AnyNativeView()
        margin.fill(with: view)
        return Group {
            margin.swiftUIView
                .previewLayout(.fixed(width: 256, height: 256))
        }
    }
}
#endif
