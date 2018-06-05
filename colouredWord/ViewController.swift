//
//  ViewController.swift
//  colouredWord
//
//  Created by Antonio Giaquinto on 14/02/2018.
//  Copyright © 2018 Antonio Giaquinto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var yes: UIButton!
    @IBOutlet weak var no: UIButton!
    
    var points = 0
    var errors = 0
    var counter = 0
    var firstGame = Bool()
    var newColor: UIColor!
    var newColorForText: UIColor!
    var seconds = 0
    var timer = Timer()
    var isTimerRunning = false
    var numberOfGames = 65

    let colorsByName = ["RED" : UIColor.red, "YELLOW" : UIColor.yellow, "GREEN" : UIColor.green, "PURPLE" : UIColor.purple, "BLUE" : UIColor.blue, "ORANGE" : UIColor.orange]
    
    let namesByColor = [UIColor.red : "RED", UIColor.yellow : "YELLOW", UIColor.green : "GREEN", UIColor.purple : "PURPLE", UIColor.blue : "BLUE", UIColor.orange : "ORANGE"]
    
//    let namesByColor = [UIColor.red : "ROSSO", UIColor.yellow : "GIALLO", UIColor.green : "VERDE", UIColor.purple : "VIOLA", UIColor.blue : "BLU", UIColor.orange : "ARANCIONE"]
    
    var colors = [UIColor.red, UIColor.yellow, UIColor.green, UIColor.purple, UIColor.blue, UIColor.orange]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firstGame = true
        play()
        runTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func play(){
        counter += 1
        if counter <= numberOfGames {
        debugPrint("Seconds: \(seconds)")

        var randomNumber = Int(arc4random_uniform((UInt32(colors.count))))
        newColor = colors[randomNumber]
        colorLabel.text = namesByColor[newColor]
        
        randomNumber = Int(arc4random_uniform(UInt32(colors.count)))
        newColorForText = colors[randomNumber]
        colorLabel.textColor = newColorForText
        errors = errors + (counter - (points + errors))
        }
    }
    
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        self.isTimerRunning = true
    }

    @objc func updateTimer(){
        
        seconds += 1
        
        if seconds == 3 {
            restartTimer()
            play()
        }
    }
    
    func restartTimer() {
        
        print("Restart ok")
        timer.invalidate()
        seconds = 0
        isTimerRunning = false
        runTimer()
    }
    
    @IBAction func yesButton(_ sender: Any) {
        
        if newColor == newColorForText {
        points += 1
            debugPrint("Points: \(points)")
        play()
        } else {
            errors += 1
            play()
        }
        errors = errors + (counter - (points+errors))
        debugPrint("Points by yes: \(points)")
        debugPrint("Errors by yes: \(errors)")
        counter += 1
        debugPrint("Counter = \(counter)")
        
        restartTimer()
    }
    
    @IBAction func noButton(_ sender: Any) {
        
        if newColor != newColorForText {
            points += 1
            play()
        } else {
            errors += 1
            play()
        }
        errors = errors + (counter - (points+errors))
        debugPrint("Points by no: \(points)")
        debugPrint("Errors by no: \(errors)")
        counter += 1
        debugPrint("Counter = \(counter)")
        
        restartTimer()
    }
}

