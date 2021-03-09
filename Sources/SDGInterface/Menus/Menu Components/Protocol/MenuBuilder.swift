/*
 MenuBuilder.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

// #workaround(Swift 5.3.3, Should be @resultBuilder.)
/// A builder that constructs lists of menu components.
public enum MenuComponentsBuilder {

  public static func buildBlock() -> EmptyMenuComponents {
    return EmptyMenuComponents()
  }

  public static func buildBlock<A>(
    _ components: A
  ) -> A
  where A: LegacyMenuComponents {
    return components
  }

  public static func buildBlock<A, B>(
    _ a: A,
    _ b: B
  ) -> MenuComponentsConcatenation<A, B>
  where A: LegacyMenuComponents, B: LegacyMenuComponents {
    return MenuComponentsConcatenation(a, b)
  }

  public static func buildBlock<A, B, C>(
    _ a: A,
    _ b: B,
    _ c: C
  ) -> MenuComponentsConcatenation<MenuComponentsConcatenation<A, B>, C>
  where A: LegacyMenuComponents, B: LegacyMenuComponents, C: LegacyMenuComponents {
    return MenuComponentsConcatenation(buildBlock(a, b), c)
  }

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
