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
        body.fillColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        body.strokeColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        body.physicsBody = SKPhysicsBody(rectangleOf: bodySize)
        body.physicsBody?.categoryBitMask = Category.customer.rawValue
        
        let head = SKShapeNode(circleOfRadius: Size.headRadius)
        head.position = CGPoint(x: 0, y: Size.bodyHight / 2)
        head.fillColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        head.strokeColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        body.addChild(head)

        mainNode = body
        arrayOfNodes = [body]
    }
}
