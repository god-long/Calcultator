//
//  HappinessVC.swift
//  Happiness
//
//  Created by 许龙 on 2017/3/20.
//  Copyright © 2017年 god-long. All rights reserved.
//

import UIKit

class HappinessVC: UIViewController, FaceViewDataSource {

    /// 0 = 非常悲伤，100 = 非常兴奋
    var happiness: Int = 75 {
        didSet {
            happiness = min(100,max(happiness, 0))
            title = "\(happiness)"
            print(happiness)
            updateFaceView()
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(faceView.scaleFace(gesture:))))
        }
    }
    
 
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    
    @IBAction func changeHappiness(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended: fallthrough
        case .changed:
            let translation = gesture.translation(in: faceView)
            let happinessChange = Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                print("happiness---- : \(happiness)")
                gesture.setTranslation(CGPoint.zero, in: faceView)
            }
            
        default: break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    func updateFaceView() {
        faceView?.setNeedsDisplay()
    }
    
    
    //MARK: FaceViewDataSource
    func smilinessForFaceView(faceView: FaceView) -> Double? {
        return (Double(happiness) - 50.0) / 50.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
