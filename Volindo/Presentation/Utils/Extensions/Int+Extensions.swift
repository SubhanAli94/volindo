import SwiftUICore

extension Int {
    func formattedString() -> String {
        if self >= 1000 {
            let value = Double(self) / 1000.0
            return String(format: "%.1fk", value) // e.g., 1200 -> "1.2k", 1000 -> "1.0k"
        }
        return String(self) // e.g., 999 -> "999"
    }
}
