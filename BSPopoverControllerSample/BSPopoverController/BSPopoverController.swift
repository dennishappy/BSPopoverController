//
//  BSPopoverController.swift
//
//
//  Created by 张亚东 on 16/5/9.
//  Copyright © 2016年 doyen. All rights reserved.
//

import UIKit

public class BSPopoverController: UIViewController {

    public typealias Animations = () -> Void
    public typealias Completion = (Bool) -> Void
    
    public var maskColor: UIColor = UIColor.clearColor() {
        didSet {
            mask.backgroundColor = maskColor
        }
    }
    
    public var statusBarStyle: UIStatusBarStyle = .Default
    public var statusBarHidden: Bool = false
    public var tapGestureEnabled: Bool = true {
        didSet {
            tap.enabled = tapGestureEnabled
        }
    }
    
    public var animationDuration: NSTimeInterval = 0.25
    public var showAnimations: Animations? = { }
    public var dismissAnimations: Animations? = { }
    public var showCompletion: Completion? = { _ in }
    public var dismissCompletion: Completion? = { _ in }
    
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BSPopoverController.handleTap(_:)))
        return tap
    }()
    
    override public func preferredStatusBarStyle() -> UIStatusBarStyle {
        return statusBarStyle
    }
    
    override public func prefersStatusBarHidden() -> Bool {
        return statusBarHidden
    }
}

extension BSPopoverController {
    
    func handleTap(tap: UITapGestureRecognizer) {
        dismiss()
    }
}


//MARK:Private
extension BSPopoverController {
    
    func prepareForShow() {
        temporaryWindow = getTempoaryWindow()
        temporaryWindow.makeKeyAndVisible()
        
        if mask.superview == nil {
            view.insertSubview(mask, atIndex: 0)
            mask.addGestureRecognizer(tap)
            mask.backgroundColor = maskColor
            mask.alpha = 0
        }

    }
    
    func finishForDismiss() {
        temporaryWindow.hidden = true
        temporaryWindow.rootViewController = nil
        temporaryWindow = nil
    }
}

//MARK:Public
public extension BSPopoverController {
    
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
extension BSPopoverController {
    
    func getTempoaryWindow() -> UIWindow {
        let window = UIWindow(frame: self.view.bounds)
        window.windowLevel = UIWindowLevelAlert
        window.rootViewController = self
        
        return window
    }
}
