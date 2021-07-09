import SpriteKit

extension SKNode {
    func fadeOutSlowDownAndRemoveFromParent(afterDelay delay: TimeInterval) {
        physicsBody?.linearDamping = 0.8
        removeAllActions()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: { [weak self] in
            self?.fadeOutAndRemove()
        })
    }
    
    private func fadeOutAndRemove() {
        let fadeOutAction = SKAction.fadeOut(withDuration: 2.0)
        let remove = SKAction.run({ removeFromParent }())
        let sequence = SKAction.sequence([fadeOutAction, remove])
        run(sequence)
    }
}
