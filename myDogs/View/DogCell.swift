//
//  DogCell.swift
//  myDogs
//
//  Created by Gurpal Bhoot on 11/5/18.
//  Copyright © 2018 Gurpal Bhoot. All rights reserved.
//

import UIKit

class DogCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogNameLbl: UILabel!
    
    // Functions
    func configureCell(dog: Dog) {
        dogNameLbl.text = dog.name
    }
}
