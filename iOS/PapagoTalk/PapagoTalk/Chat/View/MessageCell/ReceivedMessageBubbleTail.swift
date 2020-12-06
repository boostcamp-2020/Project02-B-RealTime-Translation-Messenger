//
//  ReceivedMessageBubbleTail.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/05.
//

import UIKit

class ReceivedMessageBubbleTail: UIView {

    override func draw(_ rect: CGRect) {
        let start = CGPoint(x: rect.width, y: rect.height)
        var curveTo = CGPoint.zero
        var controlPoint = CGPoint(x: rect.width, y: 0)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: curveTo,
                      controlPoint1: controlPoint,
                      controlPoint2: curveTo)
        
        curveTo = CGPoint(x: rect.width/2, y: rect.height)
        controlPoint = CGPoint(x: rect.width/2, y: rect.height/2 )
        
        path.addCurve(to: curveTo,
                      controlPoint1: controlPoint,
                      controlPoint2: curveTo)
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        
        UIColor.systemGray6.set()
        
        path.fill()
        path.close()
    }

}
