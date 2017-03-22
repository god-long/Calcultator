//
//  HappinessHistoryVC.swift
//  Psychologist
//
//  Created by 许龙 on 2017/3/22.
//  Copyright © 2017年 god-long. All rights reserved.
//

import UIKit

class HappinessHistoryVC: UIViewController {

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }
    
    var text: String = "" {
        didSet {
            textView?.text = text
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            if textView != nil && presentingViewController != nil {
                let newSize = textView.sizeThatFits(presentingViewController!.view.bounds.size)
                return CGSize(width: newSize.width, height: newSize.height + 50)
            }else {
                return super.preferredContentSize
            }
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
}
