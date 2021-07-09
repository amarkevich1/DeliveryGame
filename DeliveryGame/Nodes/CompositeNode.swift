import SpriteKit

protocol CompositeNode {
    var arrayOfNodes: [SKShapeNode] { get }
    var arrayOfJoints: [SKPhysicsJoint] { get }
}
