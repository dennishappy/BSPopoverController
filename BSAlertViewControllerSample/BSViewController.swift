//
//  BSViewController.swift
//  BSAlertControllerSample
//
//  Created by 张亚东 on 16/5/13.
//  Copyright © 2016年 blurryssky. All rights reserved.
//

import UIKit

class BSViewController: UIViewController {

    lazy var alertView: UIView = {
        
        let alert: UIView = NSBundle.mainBundle().loadNibNamed("AlertView", owner: nil, options: nil).first! as! AlertView
        alert.alpha = 0
        alert.frame = CGRectMake(0, 0, 300, 300)
        alert.center = self.alertController.view.center
        return alert
    }()
    
    lazy var alertController: BSAlertController = {
        let alertController: BSAlertController = BSAlertController()
        
        //optional properties
        alertController.tapGestureEnabled = true
        alertController.maskColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        
        
        // add '[unowned self] in' if revoke self
        alertController.showAnimations = { [unowned self] in
            self.alertView.alpha = 1
        }
        
        alertController.showCompletion = { _ in
            
            print("did show!--------------------------------------------\n")
            print("\ndid show keywindow:\n")
            print(UIApplication.sharedApplication().keyWindow!)
            
            print("\ndid show windows:\n")
            for window in UIApplication.sharedApplication().windows {
                print("\n")
                print(window)
            }
        }
        
        alertController.dismissAnimations = { [unowned self] in
            self.alertView.alpha = 0
        }
        
        alertController.dismissCompletion = { _ in
            print("did dismiss!-----------------------------------------\n")
            print("\ndid dismiss keywindow:\n")
            print(UIApplication.sharedApplication().keyWindow!)
            
            print("\ndid dismiss windows:\n")
            for window in UIApplication.sharedApplication().windows {
                print("\n")
                print(window)
            }
        }
        
        return alertController
    }()
    
    deinit {
        print("\ndeinit!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertController.contentView = alertView
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        print("\noriginal keywindow:\n")
        print(UIApplication.sharedApplication().keyWindow!)
        
        alertController.show()
    }

}
