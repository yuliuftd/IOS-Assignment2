//
//  Bubble.swift
//  Bubblepop
//
//  Created by leann on 19/5/20.
//  Copyright © 2020 leann. All rights reserved.
//

import UIKit

class Bubble :UIButton{
    
    var bubbleScore :Double = 1
    var radius: UInt32 {
        return UInt32(UIScreen.main.bounds.width / 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //make it a circle
        self.layer.cornerRadius = CGFloat(radius)
        
        let possibility = Int.random(in: 1...100)
        switch possibility{
        case 1...40:
            self.backgroundColor = UIColor.red   //40%
            self.bubbleScore = 1
        case 41...70:
            self.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1) //30%
            self.bubbleScore = 2
        case 71...85:
            self.backgroundColor = UIColor.green   //15%
            self.bubbleScore = 5
        case 86...95:
            self.backgroundColor =  #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)    //10%
            self.bubbleScore = 8
        case 96...100:
            self.backgroundColor = UIColor.black   //5%
            self.bubbleScore = 10
        default:
            print("error")
        }
        
    }
    
    
     
    func fadeIn() {
    //add animation to button
           //the effct of Fadein
           let animation = CABasicAnimation(keyPath: "opacity")
           animation.fromValue = 0
           animation.toValue = 1
        animation.duration = 0.4
           animation.repeatCount = 2.0
           animation.autoreverses = true
    
        self.layer.add(animation, forKey: nil)
    
    }
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
               shake.duration = 0.1
               shake.repeatCount = 3
               shake.autoreverses = true
               
               let fromPoint = CGPoint(x:self.center.x - 7, y:self.center.y)
               let fromValue = NSValue(cgPoint: fromPoint)
               
               let toPoint = CGPoint(x:self.center.x + 7, y:self.center.y)
               let toValue = NSValue(cgPoint: toPoint)
               
               shake.fromValue = fromValue
               shake.toValue = toValue
               
               self.layer.add(shake, forKey: nil)
    }
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.8
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        self.layer.add(pulse, forKey: nil)
    }
    
}

