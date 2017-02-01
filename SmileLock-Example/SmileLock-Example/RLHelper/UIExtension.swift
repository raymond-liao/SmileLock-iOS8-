//
//  UIExtension.swift
//  QBCloud
//
//  Created by gaoshanyu on 8/25/16.
//  Copyright © 2016 raniys. All rights reserved.
//

import UIKit

public extension UIColor {
    
    // hex sample: 0xf43737
    convenience init(hex: Int, alpha: Double = 1.0) {
        self.init(red: CGFloat((hex>>16)&0xFF)/255.0, green: CGFloat((hex>>8)&0xFF)/255.0, blue: CGFloat((hex)&0xFF)/255.0, alpha: CGFloat(255 * alpha) / 255)
    }
    
    convenience init(hexString: String, alpha: Double = 1.0) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(255 * alpha) / 255)
    }
    
}

public extension UIImage {
    
    /// To make screenshot
    ///
    /// - returns: image of screenshot
    public var screenShot: UIImage {
    
        let window = UIApplication.sharedApplication().keyWindow
        
        if UIScreen.mainScreen().respondsToSelector(#selector(NSDecimalNumberBehaviors.scale)) {
        
            UIGraphicsBeginImageContextWithOptions(window!.bounds.size, false, UIScreen.mainScreen().scale)
        
        } else {
        
            UIGraphicsBeginImageContext(window!.bounds.size)
        
        }
        
        window?.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// To make the image always up
    ///
    /// - returns: image of corrected
    func transformImageTocorrectDirection() -> UIImage {
        
        var image = self
        
        if self.imageOrientation != .Up {
            
            var transform = CGAffineTransformIdentity
            
            switch self.imageOrientation {
            case .Down, .DownMirrored:
                transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height)
                transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
            case .Left, .LeftMirrored:
                transform = CGAffineTransformTranslate(transform, self.size.width, 0)
                transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            case .Right, .RightMirrored:
                transform = CGAffineTransformTranslate(transform, 0, self.size.height)
                transform = CGAffineTransformRotate(transform, -CGFloat(M_PI_2))
            default:
                break
            }
            
            switch self.imageOrientation {
            case .UpMirrored, .DownMirrored:
                transform = CGAffineTransformTranslate(transform, self.size.width, 0)
                transform = CGAffineTransformScale(transform, -1, 1)
            case .RightMirrored, .LeftMirrored:
                transform = CGAffineTransformTranslate(transform, self.size.height, 0)
                transform = CGAffineTransformScale(transform, -1, 1)
            default:
                break
            }
            
            let ctx = CGBitmapContextCreate(nil, Int(self.size.width), Int(self.size.height),
                                            CGImageGetBitsPerComponent(self.CGImage), 0,
                                            CGImageGetColorSpace(self.CGImage),
                                            CGImageGetBitmapInfo(self.CGImage).rawValue)
            
            CGContextConcatCTM(ctx, transform)
            
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage)
            
            image = UIImage(CGImage: CGBitmapContextCreateImage(ctx)!)
            
        }
        
        return image
    }
}


public extension UIView {
    
    /// To find the parent ViewController for current view
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.nextResponder()
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    class func fromNib<T : UIView>() -> T {
        return NSBundle.mainBundle().loadNibNamed(String(T), owner: nil, options: nil)[0] as! T
    }
}

public extension UIViewController {
    
    func showNotifyAlert(title: String, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert )
        
        let yesAction = UIAlertAction(title: "确认", style: .Default, handler: nil)
        
        alert.addAction(yesAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}


