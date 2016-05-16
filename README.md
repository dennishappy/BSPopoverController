# BSPopoverController
use BSPopoverController to custom the popover view and animations

## Overview

![BSPopoverControllerGIF.gif](https://github.com/blurryssky/BSPopoverController/blob/master/ScreenShots/BSPopoverControllerGif.gif)

## Installation

> pod 'BSPopoverController', '~> 0.0.4'

## Usage

### You may need to custom the animations and the view it display, and some optional properties

```swift
let poppver: UIView = NSBundle.mainBundle().loadNibNamed("PopoverView", owner: nil, options: nil).first! as! PopoverView
poppver.alpha = 0
poppver.frame = CGRectMake(0, 0, 300, 300)
poppver.center = self.popoverController.view.center
        
        
let popoverController: BSPopoverController = BSPopoverController()
        
//optional properties
popoverController.tapGestureEnabled = true
popoverController.maskColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        
        
// add '[unowned self] in' if revoke self
popoverController.showAnimations = { [unowned self] in
    self.alertView.alpha = 1
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
    self.alertView.alpha = 0
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

//set the display view
popoverController.view.addSubview(poppverView)
```
    
### Display
```swift
//do something to prepare show
print("\noriginal keywindow:\n")
print(UIApplication.sharedApplication().keyWindow!)
        
popoverController.show()

popoverController.dismiss()
```
