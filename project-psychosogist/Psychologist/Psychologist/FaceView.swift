//
//  FaceView.swift
//  Happiness
//
//  Created by 许龙 on 2017/3/20.
//  Copyright © 2017年 god-long. All rights reserved.
//

import UIKit

protocol FaceViewDataSource: class {
    
    func smilinessForFaceView(faceView: FaceView) -> Double?
}

@IBDesignable
class FaceView: UIView {

    @IBInspectable
    var lineWidth: CGFloat = 3.0 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var color: UIColor = UIColor.orange { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var scale: CGFloat = 0.9 { didSet { setNeedsDisplay() } }
    
    private var faceCenter: CGPoint {
        return convert(center, from: superview)
    }
    
    private var faceRadius: CGFloat {
        get {
            return min(bounds.width, bounds.height) / 2 * scale
        }
    }
    
    weak var dataSource: FaceViewDataSource?
    
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    
    private enum Eye { case Left, Right }
    
    private func bezierPathForEye(whiceEye: Eye) -> UIBezierPath {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = center
        eyeCenter.y -= eyeVerticalOffset
        eyeCenter.x -= whiceEye == .Left ? eyeHorizontalSeparation / 2 : (-eyeHorizontalSeparation / 2)
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }
    
    /// fractionOfMax : -1 ... 1 非常沮丧 ... 非常高兴
    private func bezierPathForSmile(fractionOfMax: Double) -> UIBezierPath {
        
        let mouthWith = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMax, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWith / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWith, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWith / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWith / 3, y: cp1.y)

        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }

    func scaleFace(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            scale = gesture.scale
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {

        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle:CGFloat(2 * M_PI), clockwise: true)
        facePath.lineWidth = lineWidth
        color.setStroke()
        facePath.stroke()
    
        bezierPathForEye(whiceEye: .Left).stroke()
        bezierPathForEye(whiceEye: .Right).stroke()
        
        let smiliness = dataSource?.smilinessForFaceView(faceView: self) ?? 0
        bezierPathForSmile(fractionOfMax: smiliness).stroke()
    }
    

}
