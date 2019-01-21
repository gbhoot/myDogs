//
//  ViewController.swift
//  myDogs
//
//  Created by Gurpal Bhoot on 11/5/18.
//  Copyright © 2018 Gurpal Bhoot. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    // Outlets
    @IBOutlet var dogsCollectionView: UICollectionView!
    
    // Variables
    var dogs = [Dog]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupView()
    }
    
    // Functions
    func setupView() {
        dogs = DataService.instance.returnDogs()
        dogsCollectionView.reloadData()
    }
    
    func setupCollectionView() {
        dogsCollectionView.delegate = self
        dogsCollectionView.dataSource = self
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID_REUSE_DOG_CELL, for: indexPath) as? DogCell else { return UICollectionViewCell() }
        
        cell.configureCell(dog: dogs[indexPath.row])
        
        return cell
    }
}

