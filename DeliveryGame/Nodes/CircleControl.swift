import SpriteKit

class CircleControlNode: SKShapeNode {
    
    private let coefficient: CGFloat = 4

    func getVector(point: CGPoint) -> CGVector {
        let normalizedVector = simd_normalize(simd_double2(x: Double(point.x), y: Double(point.y)))
        let vector = simd_float2(x: Float(point.x), y: Float(point.y))
        let len = simd_length(vector)
        let distance = min(CGFloat(len), frame.size.height / 2)
        let dx = CGFloat(normalizedVector.x) * distance * coefficient
        let dy = CGFloat(normalizedVector.y) * distance * coefficient
        let result = CGVector(dx: dx, dy: dy)
        return result
    }
}

extension CircleControlNode {
    static func defaultControl(radius: CGFloat) -> CircleControlNode {
        let control = CircleControlNode(circleOfRadius: radius)
        control.fillColor = UIColor.lightGray.withAlphaComponent(0.5)
        control.strokeColor = UIColor.lightGray.withAlphaComponent(0.5)
        return control
    }
}
