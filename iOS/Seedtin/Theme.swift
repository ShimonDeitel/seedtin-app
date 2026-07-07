import SwiftUI

/// dried-seed olive-green on dark tin brown
enum Theme {
    static let accent = Color(red: 0.4784, green: 0.5490, blue: 0.2471)
    static let accentSecondary = Color(red: 0.1804, green: 0.2039, blue: 0.0941)
    static let background = Color(red: 0.0902, green: 0.1020, blue: 0.0549)
    static let cardBackground = background.opacity(0.6)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}
