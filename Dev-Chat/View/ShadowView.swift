//
//  ShadowView.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/18/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
import UIKit
class ShadowView : UIView{
    
    override func awakeFromNib() {
        
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        super.awakeFromNib()
    }
    
}
