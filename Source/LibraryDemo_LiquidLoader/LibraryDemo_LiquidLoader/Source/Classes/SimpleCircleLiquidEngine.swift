import Foundation
import UIKit

/**
 * This class is so fast, but allowed only same color.
 */
class SimpleCircleLiquidEngine {

    let radiusThresh: CGFloat
    fileprivate var layer: CALayer = CAShapeLayer()

    var color = UIColor()
    
    let ConnectThresh: CGFloat = 0.3
    var angleThresh: CGFloat = 0.5
    
    init(radiusThresh: CGFloat, angleThresh: CGFloat) {
        self.radiusThresh = radiusThresh
        self.angleThresh = angleThresh
    }

    func push(_ circle: LiquittableCircle, other: LiquittableCircle) -> [LiquittableCircle] {
        if let paths = generateConnectedPath(circle, other: other) {
            let layers = paths.map(self.constructLayer)
            layers.each(layer.addSublayer)
            return [circle, other]
        }
        return []
    }
    
    func draw(_ parent: UIView) {
        parent.layer.addSublayer(layer)
    }

    func clear() {
        layer.removeFromSuperlayer()
        layer.sublayers?.each{ $0.removeFromSuperlayer() }
        layer = CAShapeLayer()
    }

    func constructLayer(_ path: UIBezierPath) -> CALayer {
        let pathBounds = path.cgPath.boundingBox;

        let shape = CAShapeLayer()
        shape.fillColor = self.color.cgColor
        shape.path = path.cgPath
        shape.frame = CGRect(x: 0, y: 0, width: pathBounds.width, height: pathBounds.height)
        
        return shape
    }
    
    fileprivate func circleConnectedPoint(_ circle: LiquittableCircle, other: LiquittableCircle, angle: CGFloat) -> (CGPoint, CGPoint) {
        let vec = other.center.minus(circle.center)
        let radian = atan2(vec.y, vec.x)
        let p1 = circle.circlePoint(rad: radian + angle)
        let p2 = circle.circlePoint(rad: radian - angle)
        return (p1, p2)
    }
    
    fileprivate func circleConnectedPoint(_ circle: LiquittableCircle, other: LiquittableCircle) -> (CGPoint, CGPoint) {
        var ratio = circleRatio(circle, other: other)
        ratio = (ratio + ConnectThresh) / (1.0 + ConnectThresh)
        let angle = CGFloat(Double.pi / 2) * ratio
        return circleConnectedPoint(circle, other: other, angle: angle)
    }

    fileprivate func generateConnectedPath(_ circle: LiquittableCircle, other: LiquittableCircle) -> [UIBezierPath]? {
        if isConnected(circle, other: other) {
            let ratio = circleRatio(circle, other: other)
            switch ratio {
            case angleThresh...1.0:
                if let path = normalPath(circle, other: other) {
                    return [path]
                }
                return nil
            case 0.0..<angleThresh:
                return splitPath(circle, other: other, ratio: ratio)
            default:
                return nil
            }
        } else {
            return nil
        }
    }

    fileprivate func normalPath(_ circle: LiquittableCircle, other: LiquittableCircle) -> UIBezierPath? {
        let (p1, p2) = circleConnectedPoint(circle, other: other)
        let (p3, p4) = circleConnectedPoint(other, other: circle)
        if let crossed = CGPoint.intersection(p1, to: p3, from2: p2, to2: p4) {
            return withBezier { path in
                let r = self.circleRatio(circle, other: other)
                path.move(to: p1)
                let mul = p1.plus(p4).div(2).split(crossed, ratio: r * 1.25 - 0.25)
                path.addQuadCurve(to: p4, controlPoint: mul)
                path.addLine(to: p3)
                let mul2 = p2.plus(p3).div(2).split(crossed, ratio: r * 1.25 - 0.25)
                path.addQuadCurve(to: p2, controlPoint: mul2)
            }
        }
        return nil
    }

    fileprivate func splitPath(_ circle: LiquittableCircle, other: LiquittableCircle, ratio: CGFloat) -> [UIBezierPath] {
        let (p1, p2) = circleConnectedPoint(circle, other: other, angle: CGMath.degToRad(40))
        let (p3, p4) = circleConnectedPoint(other, other: circle, angle: CGMath.degToRad(40))

        if let crossed = CGPoint.intersection(p1, to: p3, from2: p2, to2: p4) {
            let (d1, _) = self.circleConnectedPoint(circle, other: other, angle: 0)
            let (d2, _) = self.circleConnectedPoint(other, other: circle, angle: 0)
            let r = (ratio - ConnectThresh) / (angleThresh - ConnectThresh)

            let a1 = d1.split(crossed.mid(d2), ratio: 1 - r)
            let part = withBezier { path in
                path.move(to: p1)
                path.addQuadCurve(to: p2, controlPoint: a1)
            }
            let a2 = d2.split(crossed.mid(d1), ratio: 1 - r)
            let part2 = withBezier { path in
                path.move(to: p3)
                path.addQuadCurve(to: p4, controlPoint: a2)
            }
            return [part, part2]
        }
        return []
    }

    fileprivate func circleRatio(_ circle: LiquittableCircle, other: LiquittableCircle) -> CGFloat {
        let distance = other.center.minus(circle.center).length()
        let ratio = 1.0 - (distance - radiusThresh) / (circle.radius + other.radius + radiusThresh)
        return min(max(ratio, 0.0), 1.0)
    }

    func isConnected(_ circle: LiquittableCircle, other: LiquittableCircle) -> Bool {
        let distance = circle.center.minus(other.center).length()
        return distance - circle.radius - other.radius < radiusThresh
    }

}
