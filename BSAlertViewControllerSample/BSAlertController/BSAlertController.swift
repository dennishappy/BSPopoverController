//
//  BSAlertController.swift
//  VehicleGroup
//
//  Created by 张亚东 on 16/5/9.
//  Copyright © 2016年 doyen. All rights reserved.
//

import UIKit

class BSAlertController: UIViewController {

    typealias Animations = () -> Void
    typealias Completion = (Bool) -> Void
    
    var contentView: UIView?
    
    var maskColor: UIColor! {
        didSet {
            mask.backgroundColor = maskColor
        }
    }
    
    var statusBarStyle: UIStatusBarStyle = .Default
    var statusBarHidden: Bool = false
    var tapGestureEnabled: Bool = true {
        didSet {
            tap.enabled = tapGestureEnabled
        }
    }
    
    var animationDuration: NSTimeInterval = 0.25
    var showAnimations: Animations? = { }
    var dismissAnimations: Animations? = { }
    var showCompletion: Completion? = { _ in }
    var dismissCompletion: Completion? = { _ in }
    
    private(set) var animating: Bool = false
    
    //UI
    private lazy var mask: UIView = {
        let view: UIView = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor.clearColor()
        
        return view
    }()

    private var temporaryWindow: UIWindow!
    
    //Gesture
    lazy var tap: UITapGestureRecognizer = {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BSAlertController.handleTap(_:)))
        return tap
    }()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return statusBarStyle
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return statusBarHidden
    }
}

extension BSAlertController {
    
    func handleTap(tap: UITapGestureRecognizer) {
        dismiss()
    }
}


//MARK:Private
extension BSAlertController {
    
    func prepareForShow() {
        temporaryWindow = getTempoaryWindow()
        temporaryWindow.makeKeyAndVisible()
        
        if mask.superview == nil {
            view.insertSubview(mask, atIndex: 0)
            mask.addGestureRecognizer(tap)
            mask.backgroundColor = maskColor
            mask.alpha = 0
        }
        
        guard contentView != nil else {
            return
        }
        
        view.addSubview(contentView!)
    }
    
    func finishForDismiss() {
        temporaryWindow.hidden = true
        temporaryWindow.rootViewController = nil
        temporaryWindow = nil
    }
}

//MARK:Public
extension BSAlertController {
    
    func show() {
        
        guard animating == false else {
            return
        }
        animating = true
        
        prepareForShow()
        
        UIView.animateWithDuration(animationDuration, animations: { [unowned self] in
            
            self.mask.alpha = 1
            self.showAnimations?()
            
        }) { [unowned self] (finished: Bool) in
            
            self.animating = false
            self.showCompletion?(finished)
        }
    }
    
    func dismiss() {
        guard animating == false else {
            return
        }
        animating = true
        
        UIView.animateWithDuration(animationDuration, animations: { [unowned self] in
            
            self.mask.alpha = 0
            self.dismissAnimations?()
            
        }) { [unowned self] (finished: Bool) in
            
            self.finishForDismiss()
            
            self.animating = false
            self.dismissCompletion?(finished)
        }
    }
}

//MARK:Help
extension BSAlertController {
    
    func getTempoaryWindow() -> UIWindow {
        let window = UIWindow(frame: self.view.bounds)
        window.windowLevel = UIWindowLevelAlert
        window.rootViewController = self
        
        return window
    }
}
