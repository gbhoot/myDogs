//
//  RoundedButton.swift
//  myDogs
//
//  Created by Gurpal Bhoot on 11/5/18.
//  Copyright © 2018 Gurpal Bhoot. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView(editOrCreate: false)
    }
    
    override func prepareForInterfaceBuilder() {
        customizeView(editOrCreate: false)
    }
    
    // Functions
    func customizeView(editOrCreate: Bool) {
        layer.cornerRadius = 8
    }
}
