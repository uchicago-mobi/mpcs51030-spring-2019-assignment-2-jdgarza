//
//  ViewController.swift
//  ItsAZooInThere
//
//  Created by Jessica Garza on 4/15/19.
//  Copyright © 2019 Jessica Garza. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    var animals = [Animal]()
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 1125, height: 500)
        
        scrollView.delegate = self

        let pigImage = UIImage(named: "Pig")!
        let pigSoundPath = Bundle.main.path(forResource: "ofarm.mp3", ofType:nil)
        let cowImage = UIImage(named: "Cow")!
        let cowSoundPath = Bundle.main.path(forResource: "Cow Mooing.mp3", ofType:nil)
        let wolfImage = UIImage(named: "Wolf")!
        let wolfSoundPath = Bundle.main.path(forResource: "wolf5.mp3", ofType:nil)
        
        let pig = Animal(name: "Gary", species: "Pig", age: 7, image: pigImage, soundPath: pigSoundPath)
        let cow = Animal(name: "Larry", species: "Cow", age: 21, image: cowImage, soundPath: cowSoundPath)
        let wolf = Animal(name: "Jerry", species: "Wolf", age: 7, image: wolfImage, soundPath: wolfSoundPath)
        
        animals += [pig, cow, wolf]
        
        animals.shuffle()

        
        speciesLabel.text = animals[0].species
        
        for i in 0...2{
            let button = UIButton(type: .system)
            let buttonRect = CGRect(origin:  CGPoint(x: 140 + (i * 375), y: 400), size: CGSize(width: 100, height: 100))
            button.frame = buttonRect
//            button.backgroundColor = UIColor.blue
            scrollView.addSubview(button)
            let animal = animals[i]
            let image = UIImageView(image: animal.image)
            button.setTitle(animal.name, for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            let imageRect = CGRect(origin:  CGPoint(x: 45 + (i * 375), y: 0), size: CGSize(width: image.frame.width, height: image.frame.height))
            image.frame = imageRect
            scrollView.addSubview(image)
        }
    }
    
    @objc func buttonTapped(sender: UIButton) {
        print("HEY \(sender.tag) IS CLICKING")
        
        let animal = animals[sender.tag]
        print("Animal: name = \(animal.name), species = \(animal.species), age = \(animal.age)")
        let alertController = UIAlertController(title: " ", message:
            "Animal: name = \(animal.name), species = \(animal.species), age = \(animal.age)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default))
        self.present(alertController, animated: true, completion: nil)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: animal.soundPath))
            audioPlayer?.play()
            }
            catch {
                print("Can't play the audio file.")
            }
        }
    }

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var animal = animals[0]
        var offset = Int(scrollView.contentOffset.x)
        var screen = Int(offset / 375)
        animal = animals[ screen ]
        offset = offset % 375
        let opacity = CGFloat(offset) / 188.0
        print("offset: \(offset)")
        speciesLabel.text = animal.species
        speciesLabel.alpha = 1 - opacity
        print("opacity: \(opacity)")
    print("(\(scrollView.contentOffset.x),\(scrollView.contentOffset.y))")
    }
}
