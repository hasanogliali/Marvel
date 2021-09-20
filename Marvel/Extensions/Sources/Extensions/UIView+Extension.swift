//
//  File.swift
//  
//
//  Created by Ali Hasanoğlu on 20.09.2021.
//

import UIKit

extension UIView {
    
    /// corner radius of view
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    class var cellIdentifier: String {
        return String(describing: self)
    }
}
