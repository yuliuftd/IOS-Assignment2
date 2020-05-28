//
//  newgameViewController.swift
//  Bubblepop
//
//  Created by leann on 19/5/20.
//  Copyright © 2020 leann. All rights reserved.
//

import UIKit

class newgameViewController: UIViewController {
    
    var seconds:Int = 60
    var numOfBubble: Int = 15
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var gameTimeLabel: UILabel!
    @IBOutlet weak var bubbleNumLabel: UILabel!
    
    @IBAction func timeSlider(_ sender: UISlider) {
        seconds = Int(sender.value)
        gameTimeLabel.text = String(seconds)
    }
    @IBAction func bubbleSlider(_ sender: UISlider) {
        numOfBubble = Int(sender.value)
        bubbleNumLabel.text = String(numOfBubble)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "startGame"{
            let destVC = segue.destination as! startgameViewController
            destVC.time = seconds
            destVC.bubNum = numOfBubble
            destVC.playerName = nameTextField.text!
                
          
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
