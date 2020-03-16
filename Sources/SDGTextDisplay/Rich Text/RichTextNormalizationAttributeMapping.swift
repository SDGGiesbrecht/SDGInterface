/*
 RichTextNormalizationAttributeMapping.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.1.5, Web doesn’t have foundation yet; compiler doesn’t recognize os(WASI).)
#if !canImport(Foundation)
  import SDGCollections
  import SDGText

  extension RichText.NormalizationAttribute {

    internal struct Mapping: Decodable {

      // MARK: - Initialization

      internal init(_ mapping: [Unicode.Scalar: RichText.NormalizationAttribute]) {
        self.mapping = mapping
      }

      // MARK: - Properties

      internal let mapping: [Unicode.Scalar: RichText.NormalizationAttribute]

      // MARK: - Decodable

      internal init(from decoder: Decoder) throws {
        try self.init(
          from: decoder,
          via: [String: RichText.NormalizationAttribute].self
        ) { (proxy: [String: RichText.NormalizationAttribute]) -> Mapping in
          return Mapping(proxy.mapKeys({ Unicode.Scalar(UInt32(hexadecimal: StrictString($0)))! }))
        }
      }
    }
  }
#endif
