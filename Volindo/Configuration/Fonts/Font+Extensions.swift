import SwiftUICore

extension Font {
    static func CookieRegular(size: CGFloat) -> Font {
        return .custom("Cookie-Regular", size: size)
    }
    
    static func appFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return Font.system(size: size, weight: weight, design: .default)
    }
    
    static let headline = appFont(size: 24, weight: .bold)
    static let title = appFont(size: 14, weight: .semibold)
    static let subtitle = appFont(size: 12, weight: .semibold)
    static let body = appFont(size: 12, weight: .regular)
    static let caption = appFont(size: 10, weight: .regular)
}
