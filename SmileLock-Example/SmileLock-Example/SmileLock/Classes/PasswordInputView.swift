

import UIKit

public protocol PasswordInputViewTappedProtocol: class {
    func passwordInputView(passwordInputView: PasswordInputView, tappedString: String)
}

@IBDesignable
public class PasswordInputView: UIView {
    
    //MARK: Property
    public weak var delegate: PasswordInputViewTappedProtocol?
    
    let circleView = UIView()
    let button = UIButton()
    public let label = UILabel()
    private let fontSizeRatio: CGFloat = 46 / 40
    private let borderWidthRatio: CGFloat = 1 / 26
    private var touchUpFlag = false
    private(set) public var isAnimating = false
    var isVibrancyEffect = false
    
    @IBInspectable
    public var numberString = "2" {
        didSet {
            label.text = numberString
        }
    }
    
    @IBInspectable
    public var borderColor = UIColor.darkGrayColor() {
        didSet {
            backgroundColor = borderColor
        }
    }
    
    @IBInspectable
    public var circleBackgroundColor = UIColor.whiteColor() {
        didSet {
            circleView.backgroundColor = circleBackgroundColor
        }
    }
    
    @IBInspectable
    public var textColor = UIColor.darkGrayColor() {
        didSet {
            label.textColor = textColor
        }
    }
    
    @IBInspectable
    public var highlightBackgroundColor = UIColor.grayColor()
    
    @IBInspectable
    public var highlightTextColor = UIColor.whiteColor()
    
    //MARK: Life Cycle
    #if TARGET_INTERFACE_BUILDER
    override public func willMoveToSuperview(newSuperview: UIView?) {
        configureSubviews()
    }
    #else
    override public func awakeFromNib() {
        super.awakeFromNib()
        configureSubviews()
    }
    #endif

    func touchDown() {
        //delegate callback
        delegate?.passwordInputView(self, tappedString: numberString)
        
        //now touch down, so set touch up flag --> false
        touchUpFlag = false
        touchDownAnimation()
    }
    
    func touchUp() {
        //now touch up, so set touch up flag --> true
        touchUpFlag = true
        
        //only show touch up animation when touch down animation finished
        if !isAnimating {
            touchUpAnimation()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    private func updateUI() {
        //prepare calculate
        let width = bounds.width
        let height = bounds.height
        let center = CGPoint(x: width/2, y: height/2)
        let radius = min(width, height) / 2
        let borderWidth = radius * borderWidthRatio
        let circleRadius = radius - borderWidth
        
        //update label
        label.text = numberString
        label.font = UIFont.systemFontOfSize(radius * fontSizeRatio, weight: UIFontWeightThin)
        label.textColor = textColor
        
        //update circle view
        circleView.frame = CGRect(x: 0, y: 0, width: 2 * circleRadius, height: 2 * circleRadius)
        circleView.center = center
        circleView.layer.cornerRadius = circleRadius
        circleView.backgroundColor = circleBackgroundColor
        //circle view border
        circleView.layer.borderWidth = isVibrancyEffect ? borderWidth : 0
        
        //update mask
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2.0 * CGFloat(M_PI), clockwise: false)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.CGPath
        layer.mask = maskLayer
        
        //update color
        backgroundColor = borderColor
    }
}

private extension PasswordInputView {
    //MARK: Awake
    func configureSubviews() {
        addSubview(circleView)

        //configure label
        NSLayoutConstraint.addEqualConstraintsFromSubView(label, toSuperView: self)
        label.textAlignment = .Center
        
        //configure button
        NSLayoutConstraint.addEqualConstraintsFromSubView(button, toSuperView: self)
        button.exclusiveTouch = true
        button.addTarget(self, action: #selector(PasswordInputView.touchDown), forControlEvents: [.TouchDown])
        button.addTarget(self, action: #selector(PasswordInputView.touchUp), forControlEvents: [.TouchUpInside, .TouchDragOutside, .TouchCancel, .TouchDragExit])
    }
    
    //MARK: Animation
    func touchDownAction() {
        let originFont = label.font
        label.font = UIFont.systemFontOfSize(originFont!.pointSize, weight: UIFontWeightLight)
        label.textColor = highlightTextColor
        if !self.isVibrancyEffect {
            backgroundColor = highlightBackgroundColor
        }
        circleView.backgroundColor = highlightBackgroundColor
    }
    
    func touchUpAction() {
        let originFont = label.font
        label.font = UIFont.systemFontOfSize(originFont!.pointSize, weight: UIFontWeightThin)
        label.textColor = textColor
        backgroundColor = borderColor
        circleView.backgroundColor = circleBackgroundColor
    }
    
    func touchDownAnimation() {
        isAnimating = true
        tappedAnimation({ 
            self.touchDownAction()
        }) {
            if self.touchUpFlag {
                self.touchUpAnimation()
            } else {
                self.isAnimating = false
            }
        }
    }
    
    func touchUpAnimation() {
        isAnimating = true
        tappedAnimation({ 
            self.touchUpAction()
        }) {
            self.isAnimating = false
        }
    }
    
    func tappedAnimation(animations: () -> Void, completion: (() -> ())?) {
        UIView.animateWithDuration(0.25, delay: 0, options: [.AllowUserInteraction, .BeginFromCurrentState], animations: animations) { (_) in
            completion?()
        }
    }
}

internal extension NSLayoutConstraint {
    class func addConstraints(fromView view: UIView, toView baseView: UIView, constraintInsets insets: UIEdgeInsets) {
        NSLayoutConstraint.activateConstraints([
            NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: baseView, attribute: .Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: view, attribute: .Left, relatedBy: .Equal, toItem: baseView, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: baseView, attribute: .Width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: baseView, attribute: .Height, multiplier: 1.0, constant:0)
            ])
    }
    
    class func addEqualConstraintsFromSubView(subView: UIView, toSuperView superView: UIView) {
        superView.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.addConstraints(fromView: subView, toView: superView, constraintInsets: UIEdgeInsetsZero)
    }
    
    class func addConstraints(fromSubview subview: UIView, toSuperView superView: UIView, constraintInsets insets: UIEdgeInsets) {
        superView.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.addConstraints(fromView: subview, toView: superView, constraintInsets: insets)
    }
}




