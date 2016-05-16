//
//  ViewController.swift
//  BSAlertControllerSample
//
//  Created by 张亚东 on 16/5/13.
//  Copyright © 2016年 blurryssky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        print(navigationController?.viewControllers)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("BSViewController")
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}

