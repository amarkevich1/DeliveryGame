import SpriteKit

private let rotetionDuration: TimeInterval = 1 / 10
private let shotPowerCoefficient: CGFloat = 1000

final class Deliveryman: CompositeNode {

    private struct Size {
        static let headRadius: CGFloat = 10
        static let bodyHight: CGFloat = 15
        static let bodyWeight: CGFloat = 35
        static let pizzaWeight: CGFloat = 25
        static let pizzaHight: CGFloat = 25
    }

    let mainNode: SKShapeNode
    var arrayOfNodes: [SKShapeNode] = []
    var arrayOfJoints: [SKPhysicsJoint] = []
    private var pizzaNode: SKSpriteNode?

    init(position: CGPoint) {
        let bodySize = CGSize(width: Size.bodyWeight, height: Size.bodyHight)
        let body = SKShapeNode(rectOf: bodySize)
        body.position = position
        body.fillColor = PersonAppearance.shirtColor
        body.strokeColor = PersonAppearance.shirtColor
        body.physicsBody = SKPhysicsBody(rectangleOf: bodySize)
        body.physicsBody?.allowsRotation = false
        mainNode = body
        self.addPizza()

        let head = SKShapeNode(circleOfRadius: Size.headRadius)
        head.position = CGPoint(x: 0, y: Size.bodyHight / 2)
        head.fillColor = PersonAppearance.skinTone
        head.strokeColor = PersonAppearance.skinTone
        head.zPosition = 1
        body.addChild(head)

        arrayOfNodes = [body]
    }

    func update(velocity: CGVector) {
        mainNode.physicsBody?.velocity = velocity
    }

    func rotate(toAngle angle: CGFloat, duration: TimeInterval = rotetionDuration) {
        mainNode.run(SKAction.rotate(toAngle: angle, duration: duration, shortestUnitArc: true))
    }

    func throwPizza() -> SKSpriteNode? {
        guard let pizzaNode = pizzaNode, pizzaNode.parent == mainNode else { return nil }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.addPizza()
        }
        pizzaNode.physicsBody = SKPhysicsBody(rectangleOf: pizzaNode.frame.size)
        let rotate = SKAction.rotate(byAngle: CGFloat.pi, duration: 1 / 5)
        let loop = SKAction.repeatForever(rotate)
        pizzaNode.run(loop)
        let velocityAngle = mainNode.zRotation + CGFloat.pi / 2
        let velocity = CGVector(dx: cos(velocityAngle) * shotPowerCoefficient, dy: sin(velocityAngle) * shotPowerCoefficient)
        pizzaNode.physicsBody?.velocity = velocity
        pizzaNode.physicsBody?.categoryBitMask = Category.pizza.rawValue
        pizzaNode.physicsBody?.collisionBitMask = Category([.customer, .border]).rawValue
        pizzaNode.physicsBody?.contactTestBitMask = Category([.customer, .border]).rawValue
        pizzaNode.physicsBody?.linearDamping = 0
        pizzaNode.physicsBody?.usesPreciseCollisionDetection = true
        return pizzaNode
    }

    private func addPizza() {
        let pizzaSize = CGSize(width: Size.pizzaWeight, height: Size.pizzaHight)
        let texture = SKTexture.init(image: UIImage(named: "slice-box")!)
        let pizza = SKSpriteNode(texture: texture, color: UIColor.white, size: pizzaSize)
        pizza.position = CGPoint(x: 0, y: Size.bodyHight / 2 + Size.pizzaHight / 2 + 4)
        pizza.zPosition = mainNode.zPosition
        mainNode.addChild(pizza)

        pizzaNode = pizza
    }
}
