//
//  SentMessageBubbleTail.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/05.
//

import UIKit

class SentMessageBubbleTail: UIView {

    override func draw(_ rect: CGRect) {
        let start = CGPoint(x: 0, y: rect.height)
        var curveTo = CGPoint(x: rect.width, y: 0)
        var controlPoint = CGPoint.zero
        
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
        
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        UIColor(named: "PapagoSkyBlue")?.set()
        
        path.fill()
        path.close()
    }

}
