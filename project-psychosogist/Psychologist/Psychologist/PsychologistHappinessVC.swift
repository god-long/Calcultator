//
//  PsychologistHappinessVC.swift
//  Psychologist
//
//  Created by 许龙 on 2017/3/22.
//  Copyright © 2017年 god-long. All rights reserved.
//

import UIKit

class PsychologistHappinessVC: HappinessVC, UIPopoverPresentationControllerDelegate {
    
    override var happiness: Int {
        didSet {
            history += [happiness]
        }
    }
    
    let userDefault = UserDefaults.standard
    
    var history: [Int] {
        get {
            return userDefault .object(forKey: History.HappinessHistoryKey) as? Array ?? []
        }
        set {
            userDefault.set(newValue, forKey: History.HappinessHistoryKey)
        }
    }
    
    struct History {
        static let HappinessSegueIdentifier = "history"
        static let HappinessHistoryKey = "psychologistVC.happinessHistory.history"
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.HappinessSegueIdentifier:
                if let tvc = segue.destination as? HappinessHistoryVC {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(history)"
                }
            default: break
            }
        }
    }
    
    //不自动适配iPhone
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
