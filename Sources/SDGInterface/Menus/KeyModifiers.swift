/*
 KeyModifiers.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif
#if canImport(AppKit)
  import AppKit
#endif

/// Modifier keys.
public struct KeyModifiers: OptionSet {

  // MARK: - Modifiers

  /// The command key (⌘).
  public static let command: KeyModifiers = KeyModifiers(rawValue: 1 << 0)

  /// The shift key (⇧).
  public static let shift: KeyModifiers = KeyModifiers(rawValue: 1 << 1)

  /// The option key (⌥).
  public static let option: KeyModifiers = KeyModifiers(rawValue: 1 << 2)

  /// The control key (⌃).
  public static let control: KeyModifiers = KeyModifiers(rawValue: 1 << 3)

  /// The function key (fn).
  public static let function: KeyModifiers = KeyModifiers(rawValue: 1 << 4)

  /// The caps lock key (⇪).
  public static let capsLock: KeyModifiers = KeyModifiers(rawValue: 1 << 5)

  // MARK: - Initialization

  #if canImport(AppKit)
    /// Creates key modifiers from Cocoa modifier flags.
    public init(_ cocoa: NSEvent.ModifierFlags) {
      self.init()
      if cocoa.contains(.command) {
        insert(.command)
      }
      if cocoa.contains(.shift) {
        insert(.shift)
      }
      if cocoa.contains(.option) {
        insert(.option)
      }
      if cocoa.contains(.control) {
        insert(.control)
      }
      if cocoa.contains(.function) {
        insert(.function)
      }
      if cocoa.contains(.capsLock) {
        insert(.capsLock)
      }
    }
  #endif

  // MARK: - Properties

  #if canImport(SwiftUI)
    /// The SwiftUI event modifiers.
    @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
    public func swiftUI() -> EventModifiers {
      var result = EventModifiers()
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

  #if canImport(AppKit)
    /// The Cocoa modifier flags.
    public func cocoa() -> NSEvent.ModifierFlags {
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
