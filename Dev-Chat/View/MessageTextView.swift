
//
//  MessageTextView.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/27/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

@IBDesignable class MessageTextView: UITextView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        textContainer.lineFragmentPadding = 8
    }
}
