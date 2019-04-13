//
//  UITextFieldExtension.swift
//  Catalogue
//
//  Created by Zaizen Kaegyoshi on 3/17/19.
//  Copyright © 2019 arst. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    @IBInspectable
    var leftPadding: CGFloat {
        get {
            if (self.leftView != nil) {
                return self.leftView!.frame.width
            }
            return 0.0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
    }
    @IBInspectable
    var rightPadding: CGFloat {
        get {
            if (self.rightView != nil) {
                return self.rightView!.frame.width
            }
            return 0.0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    
//    func setLeftPaddingPoints(_ amount:CGFloat){
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        self.leftView = paddingView
//        self.leftViewMode = .always
//    }
//    func setRightPaddingPoints(_ amount:CGFloat) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        self.rightView = paddingView
//        self.rightViewMode = .always
//    }
}
