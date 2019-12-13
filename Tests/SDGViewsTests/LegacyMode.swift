@testable import SDGViews

func forAllLegacyModes(_ closure: () throws -> Void) rethrows {
  for mode in [false, true] {
    try withLegacyMode(mode, closure)
  }
}

func withLegacyMode(_ closure: () throws -> Void) rethrows {
  try withLegacyMode(true, closure)
}

private func withLegacyMode(_ mode: Bool, _ closure: () throws -> Void) rethrows {
  let previous = legacyMode
  legacyMode = mode
  defer { legacyMode = previous }

  try closure()
}
