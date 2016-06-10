//
//  ViewController.swift
//  CalculaterSpaceMan
//
//  Created by Bem on 6/9/16.
//  Copyright © 2016 Bem. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var counter: UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    
    @IBAction func numberPressed(button: UIButton!) {
        playSound()
        
        runningNumber += "\(button.tag)"
        counter.text = runningNumber
        
        
    }
    
    @IBAction func clearButtonPressed(button: UIButton!) {
        playSound()
        
        runningNumber = "\(0)"
        counter.text = runningNumber
        processOperation(Operation.Empty)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
    }
    
    
    
    }
    
    @IBAction func onEqualPress(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onAddPress(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onSubtractPress(sender: AnyObject) {
        processOperation(Operation.Subtract)
        
    }
    @IBAction func onMultiplyPress(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onDividePress(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
    if currentOperation != Operation.Empty {
            
            
        if runningNumber != "" {
            rightValString = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValString)! * Double(rightValString)!)"
           
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValString)! / Double(rightValString)!)"
            
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValString)! + Double(rightValString)!)"
            
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValString)! - Double(rightValString)!)"
            }
        }
        
            leftValString = result
            counter.text = result
            
            currentOperation = op
            
        } else {
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
        
    }
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
    }
           buttonSound.play()
        }
    
    }
    


   


