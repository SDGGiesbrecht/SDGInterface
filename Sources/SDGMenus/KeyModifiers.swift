/*
 KeyModifiers.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif

/// Modifier keys.
public struct KeyModifiers: OptionSet {

  // MARK: - Modifiers

  /// ⌘
  public static let command: KeyModifiers = KeyModifiers(rawValue: 1 << 0)

  /// ⇧
  public static let shift: KeyModifiers = KeyModifiers(rawValue: 1 << 1)

  /// ⌥
  public static let option: KeyModifiers = KeyModifiers(rawValue: 1 << 2)

  /// ⌃
  public static let control: KeyModifiers = KeyModifiers(rawValue: 1 << 3)

  /// fn
  public static let function: KeyModifiers = KeyModifiers(rawValue: 1 << 4)

  /// ⇪
  public static let capsLock: KeyModifiers = KeyModifiers(rawValue: 1 << 5)

  // MARK: - Initialization

  #if canImport(AppKit)
    /// Creates key modifiers from native flags.
    public init(_ native: NSEvent.ModifierFlags) {
      self.init()
      if native.contains(.command) {
        insert(.command)
      }
      if native.contains(.shift) {
        insert(.shift)
      }
      if native.contains(.option) {
        insert(.option)
      }
      if native.contains(.control) {
        insert(.control)
      }
      if native.contains(.function) {
        insert(.function)
      }
      if native.contains(.capsLock) {
        insert(.capsLock)
      }
    }
  #endif

  // MARK: - Properties

  #if canImport(AppKit)
    /// The native flags.
    public var native: NSEvent.ModifierFlags {
      var result = NSEvent.ModifierFlags()
      if contains(.command) {
        result.insert(.command)
      }
      if contains(.shift) {
        result.insert(.shift)
      }
      if contains(.option) {
        result.insert(.option)
      }
      if contains(.control) {
        result.insert(.control)
      }
      if contains(.function) {
        result.insert(.function)
      }
      if contains(.capsLock) {
        result.insert(.capsLock)
      }
      return result
    }
  #endif

  // MARK: - OptionSet

  public init(rawValue: UInt) {
    self.rawValue = rawValue
  }

  public var rawValue: UInt
}
