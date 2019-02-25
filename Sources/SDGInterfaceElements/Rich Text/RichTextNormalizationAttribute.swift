/*
 RichTextNormalizationAttribute.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension RichText {
    internal enum NormalizationAttribute : String, Codable {

        // MARK: - Type Properties
        internal static let mapping: [Unicode.Scalar: NormalizationAttribute] = {
            let data = Resources.normalizationMapping
            let wrapper = try! JSONDecoder().decode(NormalizationAttribute.Mapping.self, from: data)
            return wrapper.mapping
        }()

        // MARK: - Cases

        case superscript
        case `subscript`
    }
}
