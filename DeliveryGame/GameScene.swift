//
//  GameScene.swift
//  DeliveryGame
//
//  Created by Alexander Markevich on 6.07.21.
//

import SpriteKit
import GameplayKit

struct Category : OptionSet {
    let rawValue: UInt32
    static let border = Category(rawValue: 1 << 0)
    static let deliveryman = Category(rawValue: 1 << 1)
    static let customer = Category(rawValue: 1 << 2)
    static let pizza = Category(rawValue: 1 << 3)
    static let ragdoll = Category(rawValue: 1 << 5)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    struct Size {
        static let cameraHorizontalInset: CGFloat = 80
        static let cameraBottomInset: CGFloat = 60
        static let cameraTopInset: CGFloat = 32
    }
    
    private var leftCircleControl: CircleControlNode?
    private var rightCircleControl: CircleControlNode?
    private var timerLabel: SKLabelNode?
    private var customersCounterLabel: SKLabelNode?
    private var timer = Timer()
    private var timerCounter: Double = 0
    private var leftCircleControlTouch: UITouch?
    private var deliveryman = Deliveryman(position: .zero)
    private var moveVector = CGVector()
    private var rotateAngle: CGFloat = 0
    private let removingDelay: TimeInterval = 0.3
    private let customersQuantity = 10

    private var customers: [Customer] = []
    
    override func didMove(to view: SKView) {
        addCamera()
        addCircleControls()
        addTimer()
        addDeliveryCounter()
        spawnCustomers()
        spawnDeliveryman()
        physicsWorld.contactDelegate = self

        startTimer()
        updateCustomersCounter()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if atPoint(location) == leftCircleControl {
                leftCircleControlTouch = touch
                guard let circleNode = leftCircleControl else { return }
                let locationInCircle = touch.location(in: circleNode)
                let vector = circleNode.getVector(point: locationInCircle)
                moveVector = vector
                let angle = atan2(vector.dy, vector.dx) - CGFloat.pi / 2
                rotateAngle = angle
            } else if atPoint(location) == rightCircleControl {
                shoot()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = leftCircleControlTouch, touches.contains(touch), let circleNode = leftCircleControl {
            let location = touch.location(in: circleNode)
            let vector = circleNode.getVector(point: location)
            moveVector = vector
            let angle = atan2(vector.dy, vector.dx) - CGFloat.pi / 2
            rotateAngle = angle
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let leftCircleControlTouch = leftCircleControlTouch,
           touches.contains(leftCircleControlTouch) {
            self.leftCircleControlTouch = nil
            moveVector = .zero
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        deliveryman.update(velocity: moveVector)
        deliveryman.rotate(toAngle: rotateAngle)
        updateCamera()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == Category([.pizza, .customer]).rawValue {
            var pizza: SKShapeNode?
            var customer: SKShapeNode?
            if contact.bodyA.categoryBitMask == Category.pizza.rawValue {
                pizza = contact.bodyA.node as? SKShapeNode
                customer = contact.bodyB.node as? SKShapeNode
            } else {
                pizza = contact.bodyB.node as? SKShapeNode
                customer = contact.bodyA.node as? SKShapeNode
            }
            pizza?.fadeOutSlowDownAndRemoveFromParent(afterDelay: removingDelay)
            
            customer?.removeFromParent()

            customers.removeAll{ $0.mainNode == customer! }
            if customers.isEmpty {
                endGame()
            }

            addFallenCustomer(color: customer?.fillColor ?? .black,
                              position: customer?.position ?? .zero,
                              velocity: pizza?.physicsBody?.velocity ?? .zero)
        } else if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == Category([.pizza, .border]).rawValue {
            if contact.bodyA.categoryBitMask == Category.pizza.rawValue {
                contact.bodyA.node?.fadeOutSlowDownAndRemoveFromParent(afterDelay: removingDelay)
            } else {
                contact.bodyB.node?.fadeOutSlowDownAndRemoveFromParent(afterDelay: removingDelay)
            }
        }
        updateCustomersCounter()
    }
    
    // MARK: - Private methods

    private func endGame() {
        stopTimer()
        let points = timerCounter
    }
    
    private func addCamera() {
        let camera = SKCameraNode()
        let needHeight: CGFloat = 500
        let currentHeigh = UIScreen.main.bounds.size.height
        let scale = needHeight / currentHeigh
        let zoomInAction = SKAction.scale(to: scale, duration: 1)
        camera.run(zoomInAction)
        scene?.addChild(camera)
        self.camera = camera
        camera.zPosition = 100
    }
    
    func updateCamera() {
        camera?.position = deliveryman.mainNode.position
    }
    
    private func addCircleControls() {

        let controlRadius: CGFloat = 70
        let leftCircleControl = CircleControlNode.defaultControl(radius: controlRadius)
        leftCircleControl.position = CGPoint(x: -size.width / 2 + controlRadius + Size.cameraHorizontalInset,
                                             y: -size.height / 2 + controlRadius + Size.cameraBottomInset)
        camera?.addChild(leftCircleControl)
        self.leftCircleControl = leftCircleControl

        let rightCircleControl = CircleControlNode.defaultControl(radius: controlRadius)
        rightCircleControl.position = CGPoint(x: size.width / 2 - controlRadius - Size.cameraHorizontalInset,
                                              y: -size.height / 2 + controlRadius + Size.cameraBottomInset)
        camera?.addChild(rightCircleControl)
        self.rightCircleControl = rightCircleControl
    }

    private func addTimer() {
        let timerLeftInset: CGFloat = 30
        let timerLabel = SKLabelNode()
        timerLabel.verticalAlignmentMode = .top
        timerLabel.horizontalAlignmentMode = .left
        timerLabel.fontSize = 64

        timerLabel.position = CGPoint(x: -timerLeftInset,
                                      y: size.height / 2 - Size.cameraTopInset)

        camera?.addChild(timerLabel)
        self.timerLabel = timerLabel
    }

    private func addDeliveryCounter() {
        let deliveryCounter = SKLabelNode()
        deliveryCounter.verticalAlignmentMode = .top
        deliveryCounter.horizontalAlignmentMode = .right
        deliveryCounter.fontSize = 56

        deliveryCounter.position = CGPoint(x: size.width / 2 - Size.cameraHorizontalInset / 2,
                                      y: size.height / 2 - Size.cameraTopInset)

        camera?.addChild(deliveryCounter)
        self.customersCounterLabel = deliveryCounter
    }
    
    private func shoot() {
        guard let pizza = deliveryman.throwPizza() else { return }
        pizza.move(toParent: self)
    }
    
    private func addFallenCustomer(color: UIColor, position: CGPoint, velocity: CGVector) {
        let ragdoll = Ragdoll(color: color, position: position)
        ragdoll.mainNode.physicsBody?.velocity = velocity
        addChild(ragdoll)
    }

    // MARK: Count clients stuff

    private func updateCustomersCounter() {
        customersCounterLabel?.text = "\(customersQuantity - customers.count)/\(customersQuantity)"
    }

    // MARK: Timer stuff

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(roundTimerFired), userInfo: nil, repeats: true)
    }

    private func stopTimer() {
        timer.invalidate()
        timerCounter = 0
    }

    @objc func roundTimerFired(_ timer: Timer) {
        timerCounter += 0.1
        timerLabel?.text = String(format: "%.1f", timerCounter)
    }
    private func spawnCustomers() {
        while (customers.count < 10) {
            let position = getRandomPosition()
            if verifyPositionForCustomer(position: position) {
                let customer = Customer(position: position)
                addChild(customer)
                customers.append(customer)
            }
        }
    }

    private func getRandomPosition() -> CGPoint {
        let backgroundNode = scene?.childNode(withName: "bg_node")
        let randomPoint = backgroundNode!.frame.randomPointInRect()
        return randomPoint
    }

    private func spawnDeliveryman() {
        addChild(deliveryman)
    }
    
    private func verifyPositionForCustomer(position: CGPoint) -> Bool {
        var points = [position]
        points.append(CGPoint(x: position.x, y: position.y + 10))
        points.append(CGPoint(x: position.x, y: position.y - 10))
        points.append(CGPoint(x: position.x, y: position.y - 20))
        points.append(CGPoint(x: position.x, y: position.y - 30))
        points.append(CGPoint(x: position.x, y: position.y - 40))
        points.append(CGPoint(x: position.x, y: position.y - 50))
        points.append(CGPoint(x: position.x, y: position.y - 60))
        points.append(CGPoint(x: position.x, y: position.y - 70))
        points.append(CGPoint(x: position.x, y: position.y - 80))
        points.append(CGPoint(x: position.x, y: position.y - 90))
        
        return !points.contains(where: { nodes(at: $0).contains(where: { $0.physicsBody != nil }) })
    }

}
