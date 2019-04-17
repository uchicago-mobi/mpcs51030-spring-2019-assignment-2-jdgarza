//
//  Animal.swift
//  ItsAZooInThere
//
//  Created by Jessica Garza on 4/16/19.
//  Copyright © 2019 Jessica Garza. All rights reserved.
//

import UIKit

class Animal: CustomStringConvertible{
    var description: String
    
    var name: String
    var species: String
    var age: Int = 0
    var image: UIImage
    var soundPath: String
    
    init(name: String, species: String, age: Int, image: UIImage, soundPath: String?) {
        self.name = name
        self.description = "Animal = \(name), \(species), \(age)"
        self.species = species
        self.image = image
        self.soundPath = soundPath!
        self.age = age
    }
    
}



