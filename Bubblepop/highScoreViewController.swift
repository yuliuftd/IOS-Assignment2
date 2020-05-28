//
//  highScoreViewController.swift
//  Bubblepop
//
//  Created by leann on 21/5/20.
//  Copyright © 2020 leann. All rights reserved.
//

import UIKit

class highScoreViewController: UIViewController {
    
    var rankingList = [String : Double]()
    var scoreSequence = [(key: String, value: Double)]()
    
    @IBOutlet weak var Player1: UILabel!
    @IBOutlet weak var Player2: UILabel!
    @IBOutlet weak var Player3: UILabel!
    @IBOutlet weak var Score1: UILabel!
    @IBOutlet weak var Score2: UILabel!
    @IBOutlet weak var Score3: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let rankingList = UserDefaults.standard.dictionary(forKey: "ranking") as! [String : Double]? {
                   scoreSequence = rankingList.sorted(by: {$0.value > $1.value})
                   
                   if scoreSequence.count == 1 {
                       Player1.text = scoreSequence[0].key
                       Score1.text = "\(scoreSequence[0].value)"
                   } else if scoreSequence.count == 2 {
                      Player1.text = scoreSequence[0].key
                       Player2.text = scoreSequence[1].key
                       Score1.text = "\(scoreSequence[0].value)"
                      Score2.text = "\(scoreSequence[1].value)"
                   } else {
                      Player1.text = scoreSequence[0].key
                      Player2.text = scoreSequence[1].key
                      Player3.text = scoreSequence[2].key
                      Score1.text = "\(scoreSequence[0].value)"
                      Score2.text = "\(scoreSequence[1].value)"
                      Score3.text = "\(scoreSequence[2].value)"
                   }
               }
        
    
        // Do any additional setup after loading the view.
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
