import SpriteKit

final class Ragdoll: CompositeNode {
    
    private struct Size {
        static let headRadius: CGFloat = 10
        static let bodyHight: CGFloat = 35
        static let bodyWeight: CGFloat = 20
        static let armTopPartHeight: CGFloat = 15
        static let armTopPartWeight: CGFloat = 5
        static let armBottomPartHeight: CGFloat = 20
        static let armBottomPartWeight: CGFloat = 4
        static let legTopPartHeight: CGFloat = 20
        static let legTopPartWeight: CGFloat = 6
        static let legBottomPartHeight: CGFloat = 25
        static let legBottomPartWeight: CGFloat = 5
    }
    
    var mainNode: SKShapeNode
    var arrayOfNodes: [SKShapeNode] = []
    var arrayOfJoints: [SKPhysicsJoint] = []
    
    init(color: SKColor, position: CGPoint) {
        
        let head = SKShapeNode(circleOfRadius: Size.headRadius)
        head.position = position
        head.fillColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        head.strokeColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        head.physicsBody = SKPhysicsBody(circleOfRadius: Size.headRadius)
        
        let bodySize = CGSize(width: Size.bodyWeight, height: Size.bodyHight)
        let body = SKShapeNode(rectOf: bodySize)
        body.position = CGPoint(x: position.x, y: position.y - Size.headRadius - Size.bodyHight / 2)
        body.fillColor = color
        body.strokeColor = color
        body.physicsBody = SKPhysicsBody(rectangleOf: bodySize)
        
        let headAndBodyJoint = SKPhysicsJointPin.joint(withBodyA: head.physicsBody!,
                                                       bodyB: body.physicsBody!,
                                                       anchor: CGPoint(x: head.position.x,
                                                                       y: head.position.y - Size.headRadius))
        
        let armTopPartSize = CGSize(width: Size.armTopPartWeight, height: Size.armTopPartHeight)
        let leftArmTopPart = SKShapeNode(rectOf: armTopPartSize)
        leftArmTopPart.position = CGPoint(x: body.position.x - Size.bodyWeight / 2 - Size.armTopPartWeight / 2,
                                          y: body.position.y + Size.bodyHight / 2 - Size.armTopPartHeight / 2)
        leftArmTopPart.fillColor = color
        leftArmTopPart.strokeColor = color
        leftArmTopPart.physicsBody = SKPhysicsBody(rectangleOf: armTopPartSize)
        
        let bodyAndLeftArmTopPartJoint = SKPhysicsJointPin.joint(withBodyA: body.physicsBody!,
                                                                 bodyB: leftArmTopPart.physicsBody!,
                                                                 anchor: CGPoint(x: body.position.x - Size.bodyWeight / 2,
                                                                                 y: body.position.y + Size.bodyHight / 2))
        
        let armBottomPartSize = CGSize(width: Size.armBottomPartWeight, height: Size.armBottomPartHeight)
        let leftArmBottomPart = SKShapeNode(rectOf: armBottomPartSize)
        leftArmBottomPart.position = CGPoint(x: leftArmTopPart.position.x,
                                             y: leftArmTopPart.position.y - Size.armTopPartHeight / 2 - Size.armBottomPartHeight / 2)
        leftArmBottomPart.fillColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        leftArmBottomPart.strokeColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        leftArmBottomPart.physicsBody = SKPhysicsBody(rectangleOf: armBottomPartSize)
        
        let leftArmTopPartAndLeftArmBottomPartJoint = SKPhysicsJointPin.joint(
            withBodyA: leftArmTopPart.physicsBody!,
            bodyB: leftArmBottomPart.physicsBody!,
            anchor: CGPoint(x: leftArmTopPart.position.x,
                            y: leftArmTopPart.position.y - Size.armTopPartHeight / 2)
        )
        
        let rightArmTopPart = SKShapeNode(rectOf: armTopPartSize)
        rightArmTopPart.position = CGPoint(x: body.position.x + Size.bodyWeight / 2 + Size.armTopPartWeight / 2,
                                           y: body.position.y + Size.bodyHight / 2 - Size.armTopPartHeight / 2)
        rightArmTopPart.fillColor = color
        rightArmTopPart.strokeColor = color
        rightArmTopPart.physicsBody = SKPhysicsBody(rectangleOf: armTopPartSize)
        
        let bodyAndRightArmTopPartJoint = SKPhysicsJointPin.joint(withBodyA: body.physicsBody!,
                                                                  bodyB: rightArmTopPart.physicsBody!,
                                                                  anchor: CGPoint(x: body.position.x + Size.bodyWeight / 2,
                                                                                  y: body.position.y + Size.bodyHight / 2))
        
        let rightArmBottomPart = SKShapeNode(rectOf: armBottomPartSize)
        rightArmBottomPart.position = CGPoint(x: rightArmTopPart.position.x,
                                              y: rightArmTopPart.position.y - Size.armTopPartHeight / 2 - Size.armBottomPartHeight / 2)
        rightArmBottomPart.fillColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        rightArmBottomPart.strokeColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        rightArmBottomPart.physicsBody = SKPhysicsBody(rectangleOf: armBottomPartSize)
        
        let rightArmTopPartAndRightArmBottomPartJoint = SKPhysicsJointPin.joint(
            withBodyA: rightArmTopPart.physicsBody!,
            bodyB: rightArmBottomPart.physicsBody!,
            anchor: CGPoint(x: rightArmTopPart.position.x,
                            y: rightArmTopPart.position.y - Size.armTopPartHeight / 2)
        )
        
        let legTopPartSize = CGSize(width: Size.legTopPartWeight, height: Size.legTopPartHeight)
        let leftLegTopPart = SKShapeNode(rectOf: legTopPartSize)
        leftLegTopPart.position = CGPoint(x: body.position.x - Size.bodyWeight / 2 + Size.legTopPartWeight / 2,
                                          y: body.position.y - Size.bodyHight / 2 - Size.legTopPartHeight / 2)
        leftLegTopPart.fillColor = color
        leftLegTopPart.strokeColor = color
        leftLegTopPart.physicsBody = SKPhysicsBody(rectangleOf: legTopPartSize)
        
        let bodyAndLeftLegTopPartJoint = SKPhysicsJointPin.joint(
            withBodyA: body.physicsBody!,
            bodyB: leftLegTopPart.physicsBody!,
            anchor: CGPoint(x: body.position.x - Size.bodyWeight / 2 + Size.legTopPartWeight / 2,
                            y: body.position.y - Size.bodyHight / 2)
        )
        
        let legBottomPartSize = CGSize(width: Size.legBottomPartWeight, height: Size.legBottomPartHeight)
        let leftLegBottomPart = SKShapeNode(rectOf: legBottomPartSize)
        leftLegBottomPart.position = CGPoint(x: leftLegTopPart.position.x,
                                         y: leftLegTopPart.position.y - Size.legTopPartHeight / 2 - Size.legBottomPartHeight / 2)
        leftLegBottomPart.fillColor = color
        leftLegBottomPart.strokeColor = color
        leftLegBottomPart.physicsBody = SKPhysicsBody(rectangleOf: legBottomPartSize)
        
        let leftLegTopPartAndLeftLegBottomPartJoint = SKPhysicsJointPin.joint(
            withBodyA: leftLegTopPart.physicsBody!,
            bodyB: leftLegBottomPart.physicsBody!,
            anchor: CGPoint(x: leftLegTopPart.position.x,
                            y: leftLegTopPart.position.y - Size.legTopPartHeight / 2)
        )
        
        
        let rightLegTopPart = SKShapeNode(rectOf: legTopPartSize)
        rightLegTopPart.position = CGPoint(x: body.position.x + Size.bodyWeight / 2 - Size.legTopPartWeight / 2,
                                           y: body.position.y - Size.bodyHight / 2 - Size.legTopPartHeight / 2)
        rightLegTopPart.fillColor = color
        rightLegTopPart.strokeColor = color
        rightLegTopPart.physicsBody = SKPhysicsBody(rectangleOf: legTopPartSize)
        
        let bodyAndRightLegTopPartJoint = SKPhysicsJointPin.joint(
            withBodyA: body.physicsBody!,
            bodyB: rightLegTopPart.physicsBody!,
            anchor: CGPoint(x: body.position.x + Size.bodyWeight / 2 - Size.legTopPartWeight / 2,
                            y: body.position.y - Size.bodyHight / 2)
        )
        
        let rightLegBottomPart = SKShapeNode(rectOf: legBottomPartSize)
        rightLegBottomPart.position = CGPoint(x: rightLegTopPart.position.x,
                                              y: rightLegTopPart.position.y - Size.legTopPartHeight / 2 - Size.legBottomPartHeight / 2)
        rightLegBottomPart.fillColor = color
        rightLegBottomPart.strokeColor = color
        rightLegBottomPart.physicsBody = SKPhysicsBody(rectangleOf: legBottomPartSize)
        
        let rightLegTopPartAndRightLegBottomPartJoint = SKPhysicsJointPin.joint(
            withBodyA: rightLegTopPart.physicsBody!,
            bodyB: rightLegBottomPart.physicsBody!,
            anchor: CGPoint(x: rightLegTopPart.position.x,
                            y: rightLegTopPart.position.y - Size.legTopPartHeight / 2)
        )
        
        mainNode = head
        arrayOfNodes = [head,
                        body,
                        leftArmTopPart,
                        leftArmBottomPart,
                        rightArmTopPart,
                        rightArmBottomPart,
                        leftLegTopPart,
                        leftLegBottomPart,
                        rightLegTopPart,
                        rightLegBottomPart]
        
        arrayOfJoints = [headAndBodyJoint,
                         bodyAndLeftArmTopPartJoint,
                         leftArmTopPartAndLeftArmBottomPartJoint,
                         bodyAndRightArmTopPartJoint,
                         rightArmTopPartAndRightArmBottomPartJoint,
                         bodyAndLeftLegTopPartJoint,
                         leftLegTopPartAndLeftLegBottomPartJoint,
                         bodyAndRightLegTopPartJoint,
                         rightLegTopPartAndRightLegBottomPartJoint]
        
//        for node in arrayOfNodes {
//
//            node.physicsBody?.linearDamping = linearDamping
//            node.physicsBody?.categoryBitMask = Category.ragdoll.rawValue
//            node.physicsBody?.collisionBitMask = Category.border.rawValue | Category.player.rawValue | Category.enemy.rawValue
//        }

    }
}
