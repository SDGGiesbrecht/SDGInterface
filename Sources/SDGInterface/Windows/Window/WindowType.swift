/*
 WindowType.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type of window.
public enum WindowType {

  /// A primary window has its own screen when in full screen mode, but does not enter fullscreen mode by default.
  ///
  /// When no size is specified, a primary window fills the available screen space (unless otherwise constrained by its content view).
  case primary(Size?)

  #if canImport(AppKit)
    /// An auxiliary windows appear on top of a different primary window when in fullscreen mode.
    ///
    /// When no size is specified, an auxiliary window takes up only a small amount of space (unless otherwise constrained by its content view).
    case auxiliary(Size?)

    /// A fullscreen window is a primary window that defaults to fullscreen mode.
    case fullscreen
  #endif
}
