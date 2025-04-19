import SwiftUI

struct ColorUtils {
    static func randomDarkColor() -> Color {
        Color(
            red: Double.random(in: 0...0.3),
            green: Double.random(in: 0...0.3),
            blue: Double.random(in: 0...0.3)
        )
    }
}
