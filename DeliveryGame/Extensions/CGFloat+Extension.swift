import UIKit

extension CGFloat {
    public static func lerp(start: CGFloat, end: CGFloat, t: CGFloat) -> CGFloat {
        return start + t * (end - start)
    }
}
