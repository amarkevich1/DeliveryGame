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
    private var pizzaNode: SKShapeNode?
    
    init(position: CGPoint) {
        let bodySize = CGSize(width: Size.bodyWeight, height: Size.bodyHight)
        let body = SKShapeNode(rectOf: bodySize)
        body.position = position
        body.fillColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        body.strokeColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        body.physicsBody = SKPhysicsBody(rectangleOf: bodySize)
        body.physicsBody?.allowsRotation = false
        mainNode = body
        self.addPizza()
        
        let head = SKShapeNode(circleOfRadius: Size.headRadius)
        head.position = CGPoint(x: 0, y: Size.bodyHight / 2)
        head.fillColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        head.strokeColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        body.addChild(head)
        
        arrayOfNodes = [body]
    }
    
    func update(velocity: CGVector) {
        mainNode.physicsBody?.velocity = velocity
    }
    
    func rotate(toAngle angle: CGFloat, duration: TimeInterval = rotetionDuration) {
        mainNode.run(SKAction.rotate(toAngle: angle, duration: duration, shortestUnitArc: true))
    }
    
    func throwPizza() -> SKShapeNode? {
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
        let pizza = SKShapeNode(rectOf: pizzaSize)
        pizza.position = CGPoint(x: 0, y: Size.bodyHight / 2 + Size.pizzaHight / 2 + 4)
        pizza.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pizza.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pizza.zPosition = -1
        mainNode.addChild(pizza)
        
        pizzaNode = pizza
    }
}
