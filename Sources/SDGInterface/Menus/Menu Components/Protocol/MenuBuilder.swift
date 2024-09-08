/*
 MenuBuilder.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

/// A builder which constructs lists of menu components.
@resultBuilder public enum MenuComponentsBuilder {

  /// Builds empty menu components.
  public static func buildBlock() -> EmptyMenuComponents {
    return EmptyMenuComponents()
  }

  /// Builds menu components.
  ///
  /// - Parameters:
  ///   - components: The menu components.
  public static func buildBlock<A>(
    _ components: A
  ) -> A
  where A: LegacyMenuComponents {
    return components
  }

  /// Builds a concatenation of two menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  public static func buildBlock<A, B>(
    _ a: A,
    _ b: B
  ) -> MenuComponentsConcatenation<A, B>
  where A: LegacyMenuComponents, B: LegacyMenuComponents {
    return MenuComponentsConcatenation(a, b)
  }

  /// Builds a concatenation of three menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  public static func buildBlock<A, B, C>(
    _ a: A,
    _ b: B,
    _ c: C
  ) -> MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>
  where A: LegacyMenuComponents, B: LegacyMenuComponents, C: LegacyMenuComponents {
    return MenuComponentsConcatenation(buildBlock(a, b), c)
  }

  /// Builds a concatenation of four menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  public static func buildBlock<A, B, C, D>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c), d)
  }

  /// Builds a concatenation of five menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  public static func buildBlock<A, B, C, D, E>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
    >, E
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c, d), e)
  }

  /// Builds a concatenation of six menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  ///   - f: The sixth menu components.
  public static func buildBlock<A, B, C, D, E, F>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
      >, E
    >, F
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents,
    F: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c, d, e), f)
  }

  /// Builds a concatenation of seven menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  ///   - f: The sixth menu components.
  ///   - g: The seventh menu components.
  public static func buildBlock<A, B, C, D, E, F, G>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
        >, E
      >, F
    >, G
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents,
    F: LegacyMenuComponents,
    G: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c, d, e, f), g)
  }

  /// Builds a concatenation of eight menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  ///   - f: The sixth menu components.
  ///   - g: The seventh menu components.
  ///   - h: The eighth menu components.
  public static func buildBlock<A, B, C, D, E, F, G, H>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
          >, E
        >, F
      >, G
    >, H
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents,
    F: LegacyMenuComponents,
    G: LegacyMenuComponents,
    H: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c, d, e, f, g), h)
  }

  /// Builds a concatenation of nine menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  ///   - f: The sixth menu components.
  ///   - g: The seventh menu components.
  ///   - h: The eighth menu components.
  ///   - i: The ninth menu components.
  public static func buildBlock<A, B, C, D, E, F, G, H, I>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
            >, E
          >, F
        >, G
      >, H
    >, I
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents,
    F: LegacyMenuComponents,
    G: LegacyMenuComponents,
    H: LegacyMenuComponents,
    I: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c, d, e, f, g, h), i)
  }

  /// Builds a concatenation of ten menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  ///   - f: The sixth menu components.
  ///   - g: The seventh menu components.
  ///   - h: The eighth menu components.
  ///   - i: The ninth menu components.
  ///   - j: The tenth menu components.
  public static func buildBlock<A, B, C, D, E, F, G, H, I, J>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I,
    _ j: J
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
              >, E
            >, F
          >, G
        >, H
      >, I
    >, J
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents,
    F: LegacyMenuComponents,
    G: LegacyMenuComponents,
    H: LegacyMenuComponents,
    I: LegacyMenuComponents,
    J: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c, d, e, f, g, h, i), j)
  }

  /// Builds a concatenation of eleven menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  ///   - f: The sixth menu components.
  ///   - g: The seventh menu components.
  ///   - h: The eighth menu components.
  ///   - i: The ninth menu components.
  ///   - j: The tenth menu components.
  ///   - k: The eleventh menu components.
  public static func buildBlock<A, B, C, D, E, F, G, H, I, J, K>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I,
    _ j: J,
    _ k: K
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
                >, E
              >, F
            >, G
          >, H
        >, I
      >, J
    >, K
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents,
    F: LegacyMenuComponents,
    G: LegacyMenuComponents,
    H: LegacyMenuComponents,
    I: LegacyMenuComponents,
    J: LegacyMenuComponents,
    K: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c, d, e, f, g, h, i, j), k)
  }

  /// Builds a concatenation of twelve menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  ///   - f: The sixth menu components.
  ///   - g: The seventh menu components.
  ///   - h: The eighth menu components.
  ///   - i: The ninth menu components.
  ///   - j: The tenth menu components.
  ///   - k: The eleventh menu components.
  ///   - l: The twelfth menu components.
  public static func buildBlock<A, B, C, D, E, F, G, H, I, J, K, L>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I,
    _ j: J,
    _ k: K,
    _ l: L
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<
                    MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
                  >, E
                >, F
              >, G
            >, H
          >, I
        >, J
      >, K
    >, L
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents,
    F: LegacyMenuComponents,
    G: LegacyMenuComponents,
    H: LegacyMenuComponents,
    I: LegacyMenuComponents,
    J: LegacyMenuComponents,
    K: LegacyMenuComponents,
    L: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c, d, e, f, g, h, i, j, k), l)
  }

  /// Builds a concatenation of thirteen menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  ///   - f: The sixth menu components.
  ///   - g: The seventh menu components.
  ///   - h: The eighth menu components.
  ///   - i: The ninth menu components.
  ///   - j: The tenth menu components.
  ///   - k: The eleventh menu components.
  ///   - l: The twelfth menu components.
  ///   - m: The thirteenth menu components.
  public static func buildBlock<A, B, C, D, E, F, G, H, I, J, K, L, M>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I,
    _ j: J,
    _ k: K,
    _ l: L,
    _ m: M
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<
                    MenuComponentsConcatenation<
                      MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
                    >, E
                  >, F
                >, G
              >, H
            >, I
          >, J
        >, K
      >, L
    >, M
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents,
    F: LegacyMenuComponents,
    G: LegacyMenuComponents,
    H: LegacyMenuComponents,
    I: LegacyMenuComponents,
    J: LegacyMenuComponents,
    K: LegacyMenuComponents,
    L: LegacyMenuComponents,
    M: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c, d, e, f, g, h, i, j, k, l), m)
  }

  /// Builds a concatenation of fourteen menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  ///   - f: The sixth menu components.
  ///   - g: The seventh menu components.
  ///   - h: The eighth menu components.
  ///   - i: The ninth menu components.
  ///   - j: The tenth menu components.
  ///   - k: The eleventh menu components.
  ///   - l: The twelfth menu components.
  ///   - m: The thirteenth menu components.
  ///   - n: The fourteenth menu components.
  public static func buildBlock<A, B, C, D, E, F, G, H, I, J, K, L, M, N>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I,
    _ j: J,
    _ k: K,
    _ l: L,
    _ m: M,
    _ n: N
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<
                    MenuComponentsConcatenation<
                      MenuComponentsConcatenation<
                        MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
                      >, E
                    >, F
                  >, G
                >, H
              >, I
            >, J
          >, K
        >, L
      >, M
    >, N
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents,
    F: LegacyMenuComponents,
    G: LegacyMenuComponents,
    H: LegacyMenuComponents,
    I: LegacyMenuComponents,
    J: LegacyMenuComponents,
    K: LegacyMenuComponents,
    L: LegacyMenuComponents,
    M: LegacyMenuComponents,
    N: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c, d, e, f, g, h, i, j, k, l, m), n)
  }

  /// Builds a concatenation of fifteen menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  ///   - f: The sixth menu components.
  ///   - g: The seventh menu components.
  ///   - h: The eighth menu components.
  ///   - i: The ninth menu components.
  ///   - j: The tenth menu components.
  ///   - k: The eleventh menu components.
  ///   - l: The twelfth menu components.
  ///   - m: The thirteenth menu components.
  ///   - n: The fourteenth menu components.
  ///   - o: The fifteenth menu components.
  public static func buildBlock<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I,
    _ j: J,
    _ k: K,
    _ l: L,
    _ m: M,
    _ n: N,
    _ o: O
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<
                    MenuComponentsConcatenation<
                      MenuComponentsConcatenation<
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
                        >, E
                      >, F
                    >, G
                  >, H
                >, I
              >, J
            >, K
          >, L
        >, M
      >, N
    >, O
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents,
    F: LegacyMenuComponents,
    G: LegacyMenuComponents,
    H: LegacyMenuComponents,
    I: LegacyMenuComponents,
    J: LegacyMenuComponents,
    K: LegacyMenuComponents,
    L: LegacyMenuComponents,
    M: LegacyMenuComponents,
    N: LegacyMenuComponents,
    O: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c, d, e, f, g, h, i, j, k, l, m, n), o)
  }

  /// Builds a concatenation of sixteen menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  ///   - f: The sixth menu components.
  ///   - g: The seventh menu components.
  ///   - h: The eighth menu components.
  ///   - i: The ninth menu components.
  ///   - j: The tenth menu components.
  ///   - k: The eleventh menu components.
  ///   - l: The twelfth menu components.
  ///   - m: The thirteenth menu components.
  ///   - n: The fourteenth menu components.
  ///   - o: The fifteenth menu components.
  ///   - p: The sixteenth menu components.
  public static func buildBlock<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I,
    _ j: J,
    _ k: K,
    _ l: L,
    _ m: M,
    _ n: N,
    _ o: O,
    _ p: P
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<
                    MenuComponentsConcatenation<
                      MenuComponentsConcatenation<
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
                          >, E
                        >, F
                      >, G
                    >, H
                  >, I
                >, J
              >, K
            >, L
          >, M
        >, N
      >, O
    >, P
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents,
    F: LegacyMenuComponents,
    G: LegacyMenuComponents,
    H: LegacyMenuComponents,
    I: LegacyMenuComponents,
    J: LegacyMenuComponents,
    K: LegacyMenuComponents,
    L: LegacyMenuComponents,
    M: LegacyMenuComponents,
    N: LegacyMenuComponents,
    O: LegacyMenuComponents,
    P: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(buildBlock(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o), p)
  }

  /// Builds a concatenation of seventeen menu components.
  ///
  /// - Parameters:
  ///   - a: The first menu components.
  ///   - b: The second menu components.
  ///   - c: The third menu components.
  ///   - d: The fourth menu components.
  ///   - e: The fifth menu components.
  ///   - f: The sixth menu components.
  ///   - g: The seventh menu components.
  ///   - h: The eighth menu components.
  ///   - i: The ninth menu components.
  ///   - j: The tenth menu components.
  ///   - k: The eleventh menu components.
  ///   - l: The twelfth menu components.
  ///   - m: The thirteenth menu components.
  ///   - n: The fourteenth menu components.
  ///   - o: The fifteenth menu components.
  ///   - p: The sixteenth menu components.
  ///   - q: The seventeenth menu components.
  public static func buildBlock<A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q>(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I,
    _ j: J,
    _ k: K,
    _ l: L,
    _ m: M,
    _ n: N,
    _ o: O,
    _ p: P,
    _ q: Q
  ) -> MenuComponentsConcatenation<
    MenuComponentsConcatenation<
      MenuComponentsConcatenation<
        MenuComponentsConcatenation<
          MenuComponentsConcatenation<
            MenuComponentsConcatenation<
              MenuComponentsConcatenation<
                MenuComponentsConcatenation<
                  MenuComponentsConcatenation<
                    MenuComponentsConcatenation<
                      MenuComponentsConcatenation<
                        MenuComponentsConcatenation<
                          MenuComponentsConcatenation<
                            MenuComponentsConcatenation<
                              MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>, D
                            >, E
                          >, F
                        >, G
                      >, H
                    >, I
                  >, J
                >, K
              >, L
            >, M
          >, N
        >, O
      >, P
    >, Q
  >
  where
    A: LegacyMenuComponents,
    B: LegacyMenuComponents,
    C: LegacyMenuComponents,
    D: LegacyMenuComponents,
    E: LegacyMenuComponents,
    F: LegacyMenuComponents,
    G: LegacyMenuComponents,
    H: LegacyMenuComponents,
    I: LegacyMenuComponents,
    J: LegacyMenuComponents,
    K: LegacyMenuComponents,
    L: LegacyMenuComponents,
    M: LegacyMenuComponents,
    N: LegacyMenuComponents,
    O: LegacyMenuComponents,
    P: LegacyMenuComponents,
    Q: LegacyMenuComponents
  {
    return MenuComponentsConcatenation(
      buildBlock(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p),
      q
    )
  }
}
