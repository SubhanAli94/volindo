import Foundation
import UIKit

extension UIScreen {
    static var screenWidth: CGFloat {
        return main.bounds.width
    }

    static var postMediaItemHeight: CGFloat {
        return screenWidth * 1.3
    }
}
