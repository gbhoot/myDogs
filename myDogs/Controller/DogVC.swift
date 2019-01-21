//
//  DogVC.swift
//  myDogs
//
//  Created by Gurpal Bhoot on 11/5/18.
//  Copyright © 2018 Gurpal Bhoot. All rights reserved.
//

import UIKit

class DogVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var dogNameLbl: UITextField!
    @IBOutlet weak var dogColorLbl: UITextField!
    @IBOutlet weak var dogRaceLbl: UITextField!
    @IBOutlet weak var dogImageButton: UIButton!
    @IBOutlet weak var submitButton: RoundedButton!
    
    // Variables
    var editOrCreate: Bool = false
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // Functions
    func setupView() {
        let backImg = UIImage(named: "brian-griffin")!.alpha(0.8)
        dogImageButton.setBackgroundImage(backImg, for: .normal)
        dogImageButton.isEnabled = true

        changeTitles()
    }
    
    func changeTitles() {
        if editOrCreate {
            self.title = "Edit Dog"
            dogImageButton.setTitle("Edit Image", for: .normal)
            submitButton.setTitle("Save", for: .normal)
            guard let idx = index else { return }
            
            let dog = DataService.instance.getDog(index: idx)
            dogNameLbl.text = dog.name
            dogColorLbl.text = dog.color
            dogRaceLbl.text = dog.race
            let image = UIImage(data: dog.image!)
            dogImageButton.setBackgroundImage(image, for: .normal)
        } else {
            self.title = "Add Dog"
            dogImageButton.setTitle("Add Image", for: .normal)
            submitButton.setTitle("Add", for: .normal)
        }
    }
    
    func disableButton() {
        dogImageButton.isEnabled = false
        dogImageButton.setTitle("", for: .normal)
    }
    
    // IB-Actions
    @IBAction func submitButtonPressed(_ sender: Any) {
        guard let name = dogNameLbl.text, let color = dogColorLbl.text, let race = dogRaceLbl.text else { return }
        
        guard let image = UIImage(named: "brian-griffin") else { return }
        let imageData : NSData = image.pngData()! as NSData
        
        if editOrCreate {
            guard let idx = self.index else { return }
            
            DataService.instance.editDog(index: idx, name: name, color: color, race: race, image: imageData)
            
            }
        DataService.instance.addDog(withName: name, aColor: color, aRace: race, andImage: imageData)
        
        dismiss(animated: true, completion: nil)
    }
}
