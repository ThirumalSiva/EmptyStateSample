//
//  EmptyStateView.swift
//  HappiHive
//
//  Created by thirumal on 5/26/17.
//  Copyright © 2017 SSB Software solutions. All rights reserved.
//

import UIKit

public protocol EmptyStateDelegate
{
    func emptyStateButtonAction(sender : UIButton)
}

@IBDesignable
class EmptyStateView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var emptyStateButton: UIButton!
    @IBOutlet weak var buttonHeightCnt: NSLayoutConstraint!
    
    var delegate: EmptyStateDelegate?

    @IBInspectable open var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    @IBInspectable open var descriptionText: String = "" {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    @IBInspectable open var isButtonHidden: Bool = false
        {
        didSet {
            emptyStateButton.isHidden = isButtonHidden
            buttonHeightCnt.constant = isButtonHidden ? 0 : 34
        }
    }
    @IBInspectable open var buttonTitle: String = ""
        {
        didSet {
            emptyStateButton.setTitle(buttonTitle, for: UIControlState.normal)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        CommonFunctions.shared.setCornerRadiusForView(emptyStateButton, cornerRadius: 5.0)
        
        CommonFunctions.shared.applyGradient(view: emptyStateButton)
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    @IBAction func emptyStateButtonAction(_ sender: UIButton)
    {
        delegate?.emptyStateButtonAction(sender: sender)
    }
}
