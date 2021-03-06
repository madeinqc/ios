//
//  UITextField.swift
//  prkng-ios
//
//  Created by Antonino Urbano on 2015-08-11.
//  Copyright (c) 2015 PRKNG. All rights reserved.
//

extension UITextField {

    func modifyClearButtonWithImageNamed(imageName: String, color: UIColor) {
        let image = UIImage(named: imageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        let button = UIButton(type: UIButtonType.Custom)
        button.setImage(image, forState: UIControlState.Normal)
        button.tintColor = color
        button.frame = CGRect(x: 0, y: 0, width: 35, height: SearchFilterView.FIELD_HEIGHT)
        button.contentMode = UIViewContentMode.Left
        button.addTarget(self, action: "textFieldClear:", forControlEvents: UIControlEvents.TouchUpInside)
        button.backgroundColor = Styles.Colors.cream1
        self.rightView = button
        self.rightViewMode = UITextFieldViewMode.Always
    }
    
    func textFieldClear(sender: AnyObject) {
        self.delegate?.textFieldShouldClear!(self)
    }
    
}
