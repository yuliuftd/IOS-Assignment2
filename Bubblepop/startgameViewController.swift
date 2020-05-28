//
//  startgameViewController.swift
//  Bubblepop
//
//  Created by leann on 18/5/20.
//  Copyright © 2020 leann. All rights reserved.
//

import UIKit

class startgameViewController: UIViewController {

    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    var time: Int = 60
    var bubNum: Int = 15
    var playerName: String = "player1"
    
    var screenWidth: UInt32 {
        return UInt32(UIScreen.main.bounds.width)
    }
    var screenHeight: UInt32 {
        return UInt32(UIScreen.main.bounds.height)
    }
    
    var bubble = Bubble()
    var bubarray = [Bubble]()
    var score: Double = 0
    var lastBubbleValue: Double = 0
    var gameTimer: Timer?
    
    var rankingList = [String: Double]()
    var lastRankingList: Dictionary? = [String: Double]()
    var scoreSequence = [(key:String, value:Double)]()
    
   
    
override func viewDidLoad() {
    
    super.viewDidLoad()
    lastRankingList = UserDefaults.standard.dictionary(forKey: "ranking") as? Dictionary<String, Double>
    if lastRankingList != nil {
        rankingList = lastRankingList!
        scoreSequence = rankingList.sorted(by: {$0.value > $1.value})
    }
    
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.setTimeRemaining()
            self.removeBubble()
            self.createBubble()
        }

}
    
    @objc func setTimeRemaining () {
        
           timeLabel.text = "\(time)"
        //   print("time:",time)
            print (playerName)
           if (time == 0 ) {
               gameTimer!.invalidate()
               checkHighScoreRecord()
             //go to highScoreViewController
            let destinationView = self.storyboard?.instantiateViewController(withIdentifier: "highScoreViewController") as! highScoreViewController
        
            self.navigationController?.pushViewController(destinationView, animated: true)
               present(destinationView, animated: true, completion: nil)
           }else {
               time -= 1
            //print("time decline")
           }
           
       }
    
    @objc func removeBubble () {
        var i = 0
        while i < bubarray.count {
            if arc4random_uniform(100) < 33 {
                let bubTobeRemoved = bubarray[i]
                bubTobeRemoved.removeFromSuperview()
                bubarray.remove(at: i)
                i = i + 1
               // print("remove successful")
            }
        }
    }
    
    func createRandomRect() -> CGRect {
        let diameter = 2 * bubble.radius
        let locationX = CGFloat(10 + arc4random_uniform(screenWidth - diameter - 20))
        let locationY = CGFloat(160 + arc4random_uniform(screenHeight - diameter - 180))
        return CGRect(x: locationX, y: locationY, width: CGFloat(diameter), height: CGFloat(diameter))
    }
    
    @objc func createBubble () {
        let  numTobeCreated = arc4random_uniform(UInt32(bubNum - bubarray.count)) + 1
        var i = 0
        while i < numTobeCreated {
            bubble = Bubble()
            
            bubble.frame = createRandomRect()
            if !overLapped(newBubble: bubble) {
                bubble.addTarget(self, action: #selector(AddScore), for: UIControl.Event.touchUpInside)
                
                self.view.addSubview(bubble)
                bubarray += [bubble]
               bubble.shake()
               bubble.fadeIn()
               bubble.pulsate()
                i += 1
                
            }
        }
    }
    
    
    @IBAction func AddScore(_ sender: Bubble) {
        
        sender.removeFromSuperview()
        lastBubbleValue = sender.bubbleScore
        currentScore.text = "\(score)"
        
        if lastBubbleValue == sender.bubbleScore {
            score = score + sender.bubbleScore * 1.5
        }else {
            score = score + sender.bubbleScore
        }
        lastBubbleValue = sender.bubbleScore
        
        
        if lastRankingList == nil {
            highscoreLabel.text = "\(score)"
        } else if scoreSequence[0].value < score {
            highscoreLabel.text = "\(score)"
        } else if scoreSequence[0].value >= score {
            highscoreLabel.text = "\(scoreSequence[0].value)"
    
    }
    }
    
    func overLapped (newBubble: Bubble) -> Bool {
        for existingBubble in bubarray{
            
            if newBubble.frame.intersects(existingBubble.frame){
            return true
            }
        }
        return false
    }

    func checkHighScoreRecord (){
        if lastRankingList == nil {
            updateHighScore()
        }else {
            rankingList = lastRankingList!
            if rankingList.keys.contains("\(playerName)") {
                let currentScore = rankingList["\(playerName)"]!
                if currentScore < score {
                    updateHighScore()
                }
            } else {
                    updateHighScore()
                }
            }
        }
        
    
    func updateHighScore () {
        rankingList.updateValue(score, forKey: "\(playerName)")
            UserDefaults.standard.set(rankingList, forKey: "ranking")
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

