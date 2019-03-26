/*
 RichTextNormalizationAttributeMapping.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) // #workaround(Temporary.)
import Foundation

import SDGLocalization
import SDGPersistence

@testable import SDGInterfaceElements

extension RichText.NormalizationAttribute.Mapping : Encodable, FileConvertible {

    // MARK: - Encodable

    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, via: mapping.mapKeys({ String($0.hexadecimalCode) }))
    }

    // MARK: - FileConvertible

    public init(file: Data, origin: URL?) throws {
        self = try JSONDecoder().decode(RichText.NormalizationAttribute.Mapping.self, from: file)
    }

    public var file: Data {
        let encoder = JSONEncoder()
        if #available(OSX 10.13, *) { // @exempt(from: unicode)
            encoder.outputFormatting.insert(.sortedKeys)
        }
        encoder.outputFormatting.insert(.prettyPrinted)
        return (try? encoder.encode(self))!
    }
}
#endif
