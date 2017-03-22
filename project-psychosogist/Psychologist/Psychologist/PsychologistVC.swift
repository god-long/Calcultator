//
//  PsychologistVC.swift
//  Psychologist
//
//  Created by 许龙 on 2017/3/22.
//  Copyright © 2017年 god-long. All rights reserved.
//

import UIKit

class PsychologistVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nothingAction() {
        performSegue(withIdentifier: "nothing", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destination = segue.destination as? UINavigationController
        
        if let hvc = destination?.visibleViewController as? HappinessVC {
            if let identifier = segue.identifier {
                switch identifier {
                case "first": hvc.happiness = 0
                case "second": hvc.happiness = 50
                case "third": hvc.happiness = 100
                case "nothing": hvc.happiness = 25
                default: break
                    
                }
            }
        }
    }
 

}
