import SpriteKit

extension SKScene {
    func addChild(_ compositeNode: CompositeNode) {
        compositeNode.arrayOfNodes.forEach { addChild($0) }
        compositeNode.arrayOfJoints.forEach { physicsWorld.add($0) }
    }
}
