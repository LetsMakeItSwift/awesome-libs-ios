import Foundation
import UIKit

public enum ObjCEffect: Int {
    case line
    case circle
    case growLine
    case growCircle
}

extension LiquidLoader {
    
   public convenience init(frame: CGRect, effect: ObjCEffect, color: UIColor, numberOfCircle: Int, duration: CGFloat, growColor: UIColor? = UIColor.red) {
        var s: Effect
        
        if effect == .line {
            s = Effect.line(color, numberOfCircle, duration, growColor)
        } else if effect == .circle {
            s = Effect.circle(color, numberOfCircle, duration, growColor)
        } else if effect == .growLine {
            s = Effect.growLine(color, numberOfCircle, duration, growColor)
        } else { //if effect == .GrowCircle {
            s = Effect.growCircle(color, numberOfCircle, duration, growColor)
        }
        
        self.init(frame: frame, effect: s)
    }
    
}
