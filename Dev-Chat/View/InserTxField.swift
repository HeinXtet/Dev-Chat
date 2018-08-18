//
//  InserTxField.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/18/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
import UIKit
class InserTxField: UITextField {
    
    
    private let padding = UIEdgeInsets(top: 0, left : 20, bottom: 0, right: 0)
    
    override func awakeFromNib() {
        setUpView()
        super.awakeFromNib()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)

    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    
    func setUpView()  {
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        self.attributedPlaceholder = placeholder
    }
    
    
    
}
