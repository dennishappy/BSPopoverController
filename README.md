# BSAlertController
UIAlertController cannot custom the view, use BSAlertController to solve it

## Overview

![BSAlertControllerGIF.gif](https://github.com/blurryssky/BSAlertController/blob/master/ScreenShots/BSAlertControllerGif.gif)

## Installation

> pod 'BSAlertController', '~> 0.0.3'

## Usage

### If you want custom a UIAlertController, you may need to custom the animations and the view it display, and some optional properties

```swift
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

//set the display view
alertController.contentView = alertView
```
    
### Display
```swift
//do something to prepare show
print("\noriginal keywindow:\n")
print(UIApplication.sharedApplication().keyWindow!)
        
alertController.show()

alertController.dismiss()
```
