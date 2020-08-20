import Foundation
import UIKit

class LiquidLineEffect : LiquidLoadEffect {

    var circleInter: CGFloat!

    override func setupShape() -> [LiquittableCircle] {

        var result: [LiquittableCircle] = []
        for i in 0 ..< numberOfCircles {
            let offset = CGFloat(i) * (self.circleInter + 2 * self.circleRadius)
            let xcomponent = self.circleInter + self.circleRadius + offset
            let ycomponent = self.loader.frame.height * 0.5
            result.append(LiquittableCircle(
                center: CGPoint(x: xcomponent, y: ycomponent),
                radius: self.circleRadius,
                color: self.color,
                growColor: self.growColor
            ))
        }
        return result
    }

    override func movePosition(_ key: CGFloat) -> CGPoint {
        if loader != nil {
            return CGPoint(
                x: (circles.last!.frame.rightBottom.x + circleInter) * sineTransform(key),
                y: loader.frame.height * 0.5
            )
        } else {
            return CGPoint.zero
        }
    }

    func sineTransform(_ key: CGFloat) -> CGFloat {
        return sin(key * CGFloat(Double.pi)) * 0.5 + 0.5
    }

    override func update() {
        switch key {
        case 0.0...2.0:
            key += 2.0/(duration*60)
        default:
            key = 0.0
        }
    }
    
    override func willSetup() {
        if circleRadius == nil {
            circleRadius = loader.frame.width * 0.05
        }
        self.circleInter = (loader.frame.width - 2 * circleRadius * CGFloat(numberOfCircles)) / CGFloat(numberOfCircles + 1)
        self.engine = SimpleCircleLiquidEngine(radiusThresh: self.circleRadius, angleThresh: 0.2)
        let moveCircleRadius = circleRadius * moveScale
        self.moveCircle = LiquittableCircle(center: CGPoint(x: 0, y: loader.frame.height * 0.5), radius: moveCircleRadius, color: color, growColor: growColor)
    }
    
    override func resize() {
        circles.map { circle in
            return (circle, circle.center.minus(self.moveCircle!.center).length())
        }.each { (circle, distance) in
            let normalized = 1.0 - distance / (self.circleRadius + self.circleInter)
            if normalized > 0.0 {
                circle.radius = self.circleRadius + (self.circleRadius * self.circleScale - self.circleRadius) * normalized
            } else {
                circle.radius = self.circleRadius
            }
        }
    }
    
}
