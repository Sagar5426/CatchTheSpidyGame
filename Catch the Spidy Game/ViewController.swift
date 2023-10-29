//
//  ViewController.swift
//  Catch the Spidy Game
//
//  Created by Sagar Jangra on 28/10/2023.
//

import UIKit

class ViewController: UIViewController {
    
    //variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var spidyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0

    // views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!

    @IBOutlet weak var spidy1: UIImageView!
    @IBOutlet weak var spidy2: UIImageView!
    @IBOutlet weak var spidy3: UIImageView!
    @IBOutlet weak var spidy4: UIImageView!
    @IBOutlet weak var spidy5: UIImageView!
    @IBOutlet weak var spidy6: UIImageView!
    @IBOutlet weak var spidy7: UIImageView!
    @IBOutlet weak var spidy8: UIImageView!
    @IBOutlet weak var spidy9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score: \(score)"
        
        //HighScore
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if (storedHighScore==nil){
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        // initialising recogniser
        let recogniser1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        // connecting views with recogniser
        spidy1.addGestureRecognizer(recogniser1)
        spidy2.addGestureRecognizer(recogniser2)
        spidy3.addGestureRecognizer(recogniser3)
        spidy4.addGestureRecognizer(recogniser4)
        spidy5.addGestureRecognizer(recogniser5)
        spidy6.addGestureRecognizer(recogniser6)
        spidy7.addGestureRecognizer(recogniser7)
        spidy8.addGestureRecognizer(recogniser8)
        spidy9.addGestureRecognizer(recogniser9)
        
        // enabling interaction
        spidy1.isUserInteractionEnabled = true
        spidy2.isUserInteractionEnabled = true
        spidy3.isUserInteractionEnabled = true
        spidy4.isUserInteractionEnabled = true
        spidy5.isUserInteractionEnabled = true
        spidy6.isUserInteractionEnabled = true
        spidy7.isUserInteractionEnabled = true
        spidy8.isUserInteractionEnabled = true
        spidy9.isUserInteractionEnabled = true
        
        spidyArray = [spidy1,spidy2,spidy3,spidy4,spidy5,spidy6,spidy7,spidy8,spidy9]
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideSpidy), userInfo: nil, repeats: true)
        
        hideSpidy()
        
        
        
        
    }
    
    @objc func hideSpidy(){
        for spidy in spidyArray{
            spidy.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(spidyArray.count-1)))
        spidyArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        score+=1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter-=1
        timeLabel.text=String(counter)
        if counter==0{
            timer.invalidate()
            hideTimer.invalidate()
            
            for spidy in spidyArray{
                spidy.isHidden = true
            }
            // HighScore
            if self.score>self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "HighScore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay function
                // using self bcz using it in here
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideSpidy), userInfo: nil, repeats: true)
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
        
            
            
        }
    }

    @IBAction func replayButton(_ sender: Any) {
        score = 0
        scoreLabel.text = "Score: \(score)"
        viewDidLoad()
    }
}

