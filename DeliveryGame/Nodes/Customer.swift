import SpriteKit

final class Customer: CompositeNode {
    private struct Size {
        static let headRadius: CGFloat = 10
        static let bodyHight: CGFloat = 15
        static let bodyWeight: CGFloat = 35
    }
    
    let mainNode: SKShapeNode
    var arrayOfNodes: [SKShapeNode] = []
    var arrayOfJoints: [SKPhysicsJoint] = []
    private(set) var body = SKShapeNode()
    private(set) var head = SKShapeNode()
    
    init(position: CGPoint) {
        let bodySize = CGSize(width: Size.bodyWeight, height: Size.bodyHight)
        body = SKShapeNode(rectOf: bodySize)
        body.position = position
        body.fillColor = PersonAppearance.shirtColor
        body.strokeColor = body.fillColor
        body.physicsBody = SKPhysicsBody(rectangleOf: bodySize)
        body.physicsBody?.categoryBitMask = Category.customer.rawValue
        
        head = SKShapeNode(circleOfRadius: Size.headRadius)
        head.position = CGPoint(x: 0, y: Size.bodyHight / 2)
        head.fillColor = PersonAppearance.skinTone
        head.strokeColor = head.fillColor
        body.addChild(head)

        mainNode = body
        arrayOfNodes = [body]
    }
}


