//
//  DataService.swift
//  myDogs
//
//  Created by Gurpal Bhoot on 11/5/18.
//  Copyright © 2018 Gurpal Bhoot. All rights reserved.
//

import UIKit
import CoreData

class DataService {
    
    static let instance = DataService()
    
    private var dogs = [Dog]()
    
    func addDog(withName: String, aColor: String, aRace: String, andImage: NSData) {
        self.save(create: true, name: withName, color: aColor, race: aRace, image: andImage) { (success) in
            if success {
                print("Created and saved")
            }
        }
    }
    
    func getDog(index: Int) -> Dog {
        return dogs[index]
    }
    
    func editDog(index: Int, name: String, color: String, race: String, image: NSData) {
        let dog = dogs[index]
        dog.name = name
        dog.color = color
        dog.race = race
        dog.image = image as Data
        self.save(create: false, name: nil, color: nil, race: nil, image: nil) { (success) in
            if success {
                print("Edited and saved")
            }
        }
    }

    func removeDog(index: Int) {
        delete(index: index) { (success) in
            if success {
                print("Removed and saved")
            }
        }
    }
    
    func returnDogs() -> [Dog] {
        fetchCoreDataObjects()
        
        return dogs
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (success) in
            if success {
                print("Successfully fetched data")
            }
        }
    }
    
    func fetch(completion: CompletionHandler) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Dog>(entityName: "Dog")
        
        do {
            dogs = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            print("Could not getch data, \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func save(create: Bool, name: String?, color: String?, race: String?, image: NSData?, completion: CompletionHandler) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        if create {
            guard let nm = name, let col = color, let rc = race, let img = image else { return }
            let dog = Dog(context: managedContext)
            
            dog.name = nm
            dog.color = col
            dog.race = rc
            dog.image = img as Data
        }
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            print("Couldn't save data: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func delete(index: Int, completion: CompletionHandler) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(dogs[index])
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            print("Could not remove: \(error.localizedDescription)")
            completion(false)
        }
    }
}
