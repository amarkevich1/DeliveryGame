import SpriteKit

extension SKNode {
    func removeFromParent(afterDelay delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: { [weak self] in
            self?.removeFromParent()
        })
    }
}
