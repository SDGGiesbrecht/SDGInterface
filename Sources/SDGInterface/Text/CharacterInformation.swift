/*
 CharacterInformation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if PLATFORM_HAS_COCOA_INTERFACE
  import Foundation
  #if canImport(CoreGraphics)
    import CoreGraphics
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow
  import SDGLogic
  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  /// User‐presentable Unicode information about the characters in a string.
  public struct CharacterInformation {

    // MARK: - Static Methods

    /// Displays information to the user about the characters in a string.
    ///
    /// - Parameters:
    ///     - characters: The string whose characters should be described.
    ///     - origin: The view and selection the characters originate from. If provided, the information will be shown in a pop‐up view instead of a separate window.
    public static func display(
      for characters: String,
      origin: (view: CocoaView, selection: Rectangle?)?
    ) {
      var details: [CharacterInformation] = []
      details.reserveCapacity(characters.scalars.count)
      for scalar in characters.scalars {
        details.append(CharacterInformation(scalar))
      }

      let table = Table<CharacterInformation>(
        data: Shared(details),
        columns: [
          { details in
            // @exempt(from: tests) iOS does not call this unless it displays.
            let codePoint = Label<InterfaceLocalization>(
              UserFacing({ _ in details.codePoint }),
              colour: details.warningColour
            )
            return AnyView(codePoint)
          },
          { details in
            // @exempt(from: tests) iOS does not call this unless it displays.
            let codePoint = CompatibilityLabel<InterfaceLocalization>(
              UserFacing({ _ in details.character }),
              colour: details.warningColour
            )
            return AnyView(codePoint)
          },
          { details in
            // @exempt(from: tests) iOS does not call this unless it displays.
            return AnyView(
              Label<InterfaceLocalization>(
                UserFacing({ _ in StrictString(details.normalizedCodePoints) })
              )
            )
          },
          { details in
            // @exempt(from: tests) iOS does not call this unless it displays.
            return AnyView(
              Label<InterfaceLocalization>(
                UserFacing({ _ in StrictString(details.normalizedCharacters) })
              )
            )
          },
        ]
      )

      if let origin = origin {
        #if canImport(AppKit)
          let preferredSize = Size.auxiliaryWindow
          let resolvedContent = table.frame(
            minWidth: preferredSize.width,
            minHeight: preferredSize.height,
            alignment: .topLeading
          )
        #else
          let resolvedContent = table.cocoa()
        #endif
        origin.view.displayPopOver(
          resolvedContent,
          attachmentAnchor: origin.selection.map({ AttachmentAnchor.rectangle(.rectangle($0)) })
            ?? .rectangle(.bounds)
        )
      } else {
        #if canImport(AppKit)
          let window = Window(
            type: .auxiliary(nil),
            name: UserFacing<StrictString, AnyLocalization>({ _ in StrictString(characters) }),
            content: table.padding()
          )
          window.display()
        #endif
      }
    }

    // MARK: - Initialization

    private init(_ character: Unicode.Scalar) {
      let characterString = String(character)
      codePoint = StrictString(character.hexadecimalCode)

      var normalizedCharacters = StrictString(character)
      if normalizedCharacters.scalars.elementsEqual(characterString.unicodeScalars) {
        normalizedCharacters = ""
      }

      var normalizedCodePointsString: StrictString = ""
      for scalar in normalizedCharacters.scalars {
        if ¬normalizedCodePointsString.isEmpty {
          normalizedCodePointsString += " "
        }

        normalizedCodePointsString += StrictString(scalar.hexadecimalCode)
      }
      normalizedCodePoints = normalizedCodePointsString

      if ¬normalizedCharacters.isEmpty {
        if characterString ≠ characterString.decomposedStringWithCompatibilityMapping {
          // Compatibility character.
          warningColour = .red
        } else {
          // Precomposed, but still canonical
          warningColour = .blue
        }
      } else {
        switch character {
        case "\u{22}", "\u{27}", "\u{2D}", "\\", "^", "_", "`", "~":
          warningColour = Colour(red: 0.5, green: 0.5, blue: 0)  // Code‐only ASCII
        default:
          warningColour = .black  // Normal
        }
      }

      self.character = character.visibleRepresentation
      let printable = normalizedCharacters.scalars.map { StrictString($0.visibleRepresentation) }
      self.normalizedCharacters = printable.reduce("") { $0 + $1 }
    }

    // MARK: - Properties

    private let character: String
    private let codePoint: StrictString
    private let normalizedCodePoints: StrictString
    private let normalizedCharacters: StrictString
    private let warningColour: Colour
  }
#endif
