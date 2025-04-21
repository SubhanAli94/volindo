import XCTest

final class HeaderViewUI {
    
    private var app: XCUIApplication!
    
    init(app: XCUIApplication) { self.app = app }
    
    static let chevronDown = "headerView_chevron_down"
    static let heartIcon = "headerView_heartIcon"
    static let messageIcon = "headerView_messageIcon"
    
    public var logoText:   XCUIElement { app.staticTexts[AccessibilityIdentifiers.HeaderView.logoText] }
    public var chevronDown:   XCUIElement { app.images[AccessibilityIdentifiers.HeaderView.chevronDown] }
    public var heartIcon:   XCUIElement { app.images[AccessibilityIdentifiers.HeaderView.heartIcon] }
    public var messageIcon:   XCUIElement { app.images[AccessibilityIdentifiers.HeaderView.messageIcon] }
}
