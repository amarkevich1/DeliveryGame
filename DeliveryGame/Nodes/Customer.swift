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
    
    init(position: CGPoint) {
        let bodySize = CGSize(width: Size.bodyWeight, height: Size.bodyHight)
        let body = SKShapeNode(rectOf: bodySize)
        body.position = position
        body.fillColor = PersonAppearance.shirtColor
        body.strokeColor = PersonAppearance.shirtColor
        body.physicsBody = SKPhysicsBody(rectangleOf: bodySize)
        body.physicsBody?.categoryBitMask = Category.customer.rawValue
        
        let head = SKShapeNode(circleOfRadius: Size.headRadius)
        head.position = CGPoint(x: 0, y: Size.bodyHight / 2)
        head.fillColor = PersonAppearance.skinTone
        head.strokeColor = PersonAppearance.skinTone
        body.addChild(head)

        mainNode = body
        arrayOfNodes = [body]
    }
}


