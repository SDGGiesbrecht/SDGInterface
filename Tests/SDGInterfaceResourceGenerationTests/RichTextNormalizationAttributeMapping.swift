/*
 RichTextNormalizationAttributeMapping.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGInterfaceElements

extension RichText.NormalizationAttribute.Mapping : Encodable {

    // MARK: - Encodable

    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: mapping.mapKeys({ $0.value }))
    }
}
