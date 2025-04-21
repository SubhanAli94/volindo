import XCTest

final class VolindoUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var headerView: HeaderViewUI!
    
    override func setUp() {
        app = XCUIApplication()
        headerView = HeaderViewUI(app: app)
        continueAfterFailure = false
        app.launch()
        
       testHeaderTests()
    }
    
    func testHeaderTests(){
        XCTAssert(headerView.logoText.exists)
        XCTAssert(headerView.chevronDown.exists)
        XCTAssert(headerView.heartIcon.exists)
        XCTAssert(headerView.messageIcon.exists)
    }
    
}
