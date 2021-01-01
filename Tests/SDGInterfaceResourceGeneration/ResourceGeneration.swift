/*
 ResourceGeneration.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import XCTest

  import SDGText
  import SDGLocalization
  import SDGPersistence

  @testable import SDGTextDisplay

  final class ResourceGeneration: XCTestCase {

    // Complete the word “test” to activate and run the generators.

    func tesRefreshUnicodeData() throws {
      let ucd = URL(string: "https://www.unicode.org/Public/UCD/latest/ucd")!
      let unicodeDataURL = ucd.appendingPathComponent("UnicodeData.txt")
      let unicodeData = try String(from: unicodeDataURL)

      var compatibility = [Unicode.Scalar: RichText.NormalizationAttribute]()

      for line in unicodeData.lines {
        let entry = line.line
        if entry.isEmpty {
          continue
        }

        let fields = entry.components(separatedBy: ";".scalars)
        XCTAssertEqual(
          fields.count,
          15,
          "Unexpected number of fields. Field indices may be mismatched: \(fields.map({ String($0.contents) }))"
        )

        let decomposition = fields[5].contents
        var possibleAttribute: RichText.NormalizationAttribute?
        if decomposition.hasPrefix("<super>".scalars) {
          possibleAttribute = .superscript
        } else if decomposition.hasPrefix("<sub>".unicodeScalars) {
          possibleAttribute = .subscript
        }
        if let attribute = possibleAttribute {
          let character = Unicode.Scalar(UInt32(hexadecimal: StrictString(fields[0].contents)))!
          compatibility[character] = attribute
        }
      }

      let mapping = RichText.NormalizationAttribute.Mapping(compatibility)
      let mappingURL = textDisplayResourcesDirectory.appendingPathComponent(
        "Normalization Mapping.json"
      )
      try mapping.save(to: mappingURL)
      try String(from: mappingURL).appending("\n").save(to: mappingURL)
    }
  }
#endif
