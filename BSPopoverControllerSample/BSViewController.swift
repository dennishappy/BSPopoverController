//
//  BSViewController.swift
//  BSpopoverControllerSample
//
//  Created by 张亚东 on 16/5/13.
//  Copyright © 2016年 blurryssky. All rights reserved.
//

import UIKit

class BSViewController: UIViewController {

    lazy var poppverView: UIView = {
        
        let poppver: UIView = NSBundle.mainBundle().loadNibNamed("PopoverView", owner: nil, options: nil).first! as! PopoverView
        poppver.alpha = 0
        poppver.frame = CGRectMake(0, 0, 300, 300)
        poppver.center = self.popoverController.view.center
        return poppver
    }()
    
    lazy var popoverController: BSPopoverController = {
        let popoverController: BSPopoverController = BSPopoverController()
        
        //optional properties
        popoverController.tapGestureEnabled = true
        popoverController.maskColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        
        
        // add '[unowned self] in' if revoke self
        popoverController.showAnimations = { [unowned self] in
            self.poppverView.alpha = 1
        }
        
        popoverController.showCompletion = { _ in
            
            print("did show!--------------------------------------------\n")
            print("\ndid show keywindow:\n")
            print(UIApplication.sharedApplication().keyWindow!)
            
            print("\ndid show windows:\n")
            for window in UIApplication.sharedApplication().windows {
                print("\n")
                print(window)
            }
        }
        
        popoverController.dismissAnimations = { [unowned self] in
            self.poppverView.alpha = 0
        }
        
        popoverController.dismissCompletion = { _ in
            print("did dismiss!-----------------------------------------\n")
            print("\ndid dismiss keywindow:\n")
            print(UIApplication.sharedApplication().keyWindow!)
            
            print("\ndid dismiss windows:\n")
            for window in UIApplication.sharedApplication().windows {
                print("\n")
                print(window)
            }
        }
        
        return popoverController
    }()
    
    deinit {
        print("\ndeinit!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popoverController.view.addSubview(poppverView)
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        print("\noriginal keywindow:\n")
        print(UIApplication.sharedApplication().keyWindow!)
        
        popoverController.show()
    }

}
