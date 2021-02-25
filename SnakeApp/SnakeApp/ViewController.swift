//
//  ViewController.swift
//  SnakeApp
//
//  Created by Alex Pettigrew.
//

import UIKit

class ViewController: UIViewController {

    var currentScore = 0
    var bestScore = 0
    
    var gameTimer = Timer()
    var timerDisplayed = 60
    var timeStart = false
    var checkTimer = Timer()
    var speed2xTimer = Timer()
    var timeStartSpeed = false
    var point2xTimer = Timer()
    var timeStartPoint = false
    
    var x = 10
    var y = 10
    
    var upButton = -20
    var downButton = 20
    var rightButton = 20
    var leftButton = -20
    var upButton2x = -40
    var downButton2x = 40
    var rightButton2x = 40
    var leftButton2x = -40
    
    var speed2x = false
    var speed2xMove = true
    var point2x = false
    var point2xMove = true
    
    
    var randomXLocation = 0
    var randomYLocation = 0
    
    let randomXArray = [1,5,9,13,17,21,25,29]
    
    let randomYArray = [1,5,9,13,17,21,25,29,33,37,41,45,49,53,57]
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var finishImageView: UIImageView!
    
    @IBOutlet weak var point2xImage: UIImageView!
    
    @IBOutlet weak var speed2xImage: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomXLocation = randomXArray.randomElement()! * 10
        randomYLocation = randomYArray.randomElement()! * 10
        
        finishImageView.center = CGPoint(x: randomXLocation, y:randomYLocation)
        
        characterImage.center = CGPoint(x: x, y: y)
        
        point2xImage.isHidden = true
        point2xImage.center = CGPoint(x: 0, y: 580)
        speed2xImage.isHidden = true
        speed2xImage.center = CGPoint(x: 300, y: 580)
    }
    
    func pointAdd()
    {
        if characterImage.center == finishImageView.center
        {
            randomXLocation = randomXArray.randomElement()! * 10
            randomYLocation = randomYArray.randomElement()! * 10
            
            finishImageView.center = CGPoint(x: randomXLocation, y: randomYLocation)
            
            if point2x == false
            {
                currentScore += 1
                scoreLabel.text = "Score:\(currentScore)"
            }
            else
            {
                point2xImage.isHidden = true
                currentScore += 2
                scoreLabel.text = "Score:\(currentScore)"
            }
        }
    }
    
    func timerStart()
    {
        timeStart = true
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
    }
    
    @objc func Action()
    {
        timerDisplayed -= 1
        timeLabel.text = "Time:\(timerDisplayed)"
       
        if timerDisplayed == 0
        {
            gameOver()
        }
        
        if speed2x == true
        {
            speed2xImage.isHidden = true
        }
        
        if point2x == true
        {
            point2xImage.isHidden = true
        }
    }
    
    func timerStartSpeed()
    {
        timeStartSpeed = true
        
        speed2xTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SpeedAction), userInfo: nil, repeats: true)
    }
    
    @objc func SpeedAction()
    {
        speed2xPowerUp()
        
        if speed2x == true
        {
            speed2xTimer.invalidate()
        }
    }
    
    func timerStartPoint()
    {
        timeStartPoint = true
        
        point2xTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PointAction), userInfo: nil, repeats: true)
    }
    
    @objc func PointAction()
    {
        point2xPowerUp()
        
        if point2x == true
        {
            point2xTimer.invalidate()
        }
    }
    
    func speed2xPowerUp()
    {
        if currentScore >= 2
        {
            speed2xImage.isHidden = false
            speed2xMove = false
        }
        
        if speed2xMove == true
        {
            randomXLocation = randomXArray.randomElement()! * 10
            randomYLocation = randomYArray.randomElement()! * 10
            
            speed2xImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
        }
        
    }
    
    func point2xPowerUp()
    {
        if currentScore >= 8
        {
            point2xImage.isHidden = false
            point2xMove = false
        }
        
        if point2xMove == true
        {
            randomXLocation = randomXArray.randomElement()! * 10
            randomYLocation = randomYArray.randomElement()! * 10
            
            point2xImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
        }
    }
    
    func speed2xPowerUpActive()
    {
        if characterImage.center == speed2xImage.center
        {
            if speed2xImage.isHidden == false
            {
                speed2xImage.isHidden = true
                speed2x = true
                speed2xImage.center = CGPoint(x: 300, y: 580)
            }
        }
    }
    
    func point2xPowerUpActive()
    {
        if characterImage.center == point2xImage.center
        {
            if point2xImage.isHidden == false
            {
                point2xImage.isHidden = true
                point2x = true
                point2xImage.center = CGPoint(x: 0, y: 580)
            }
        }
    }
    
    @IBAction func upButton(_ sender: Any)
    {
        if timeStart == false
        {
            timerStart()
        }
        
        if timeStartSpeed == false
        {
            timerStartSpeed()
        }
        
        if timeStartPoint == false
        {
            timerStartPoint()
        }
        
        if y <= 15
        {
            return
        }
        
        if speed2x == true
        {
            y += upButton2x
            speed2xImage.isHidden = true
        }
        else
        {
            y += upButton
        }
        characterImage.center = CGPoint(x: x, y: y)
       
        pointAdd()
        speed2xPowerUpActive()
        point2xPowerUpActive()

    }
    
    @IBAction func downButton(_ sender: Any)
    {
        if timeStart == false
        {
            timerStart()
        }
        
        if timeStartSpeed == false
        {
            timerStartSpeed()
        }
        
        if timeStartPoint == false
        {
            timerStartPoint()
        }
        
        if y >= 570
        {
            return
        }
        
        if speed2x == true
        {
            y += downButton2x
            speed2xImage.isHidden = true
        }
        else
        {
            y += downButton
        }
        characterImage.center = CGPoint(x: x, y: y)
        
        pointAdd()
        speed2xPowerUpActive()
        point2xPowerUpActive()

    }
    
    @IBAction func rightButton(_ sender: Any)
    {
        if timeStart == false
        {
            timerStart()
        }
        
        if timeStartSpeed == false
        {
            timerStartSpeed()
        }
        
        if timeStartPoint == false
        {
            timerStartPoint()
        }
        
        if x >= 285{
            return
        }
        
        if speed2x == true
        {
            x += rightButton2x
            speed2xImage.isHidden = true
        }
        else
        {
            x += rightButton
        }
        characterImage.center = CGPoint(x: x, y: y)
        
        pointAdd()
        speed2xPowerUpActive()
        point2xPowerUpActive()

    }
    
    @IBAction func leftButton(_ sender: Any)
    {
        if timeStart == false
        {
            timerStart()
        }
        
        if timeStartSpeed == false
        {
            timerStartSpeed()
        }
        
        if timeStartPoint == false
        {
            timerStartPoint()
        }
        
        if x <= 15
        {
            return
        }
        
        if speed2x == true
        {
            x += leftButton2x
            speed2xImage.isHidden = true
        }
        else
        {
            x += leftButton
        }
        
        characterImage.center = CGPoint(x: x, y: y)
        
        pointAdd()
        speed2xPowerUpActive()
        point2xPowerUpActive()

    }
    
    func gameOver()
    {
        gameTimer.invalidate()
        
        if bestScore < currentScore
        {
            bestScore = currentScore
        }
        
        let alert = UIAlertController(title: "Game Over", message: "Best Score:\(bestScore)", preferredStyle: UIAlertController.Style.alert)
        
        let ok = UIAlertAction(title: "Reset", style: .default)
        {
            UIAlertAction in
            NSLog("Reset Pressed")
            self.reset()
        }
       
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    func reset()
    {
        randomXLocation = randomXArray.randomElement()! * 10
        randomYLocation = randomYArray.randomElement()! * 10
        
        finishImageView.center = CGPoint(x: randomXLocation, y:randomYLocation)
        
        x = 10
        y = 10
        
        characterImage.center = CGPoint(x: x, y: y)
        
        currentScore = 0
        scoreLabel.text = "Score:\(currentScore)"
        timeStart = false
        timerDisplayed = 60
        timeLabel.text = "Time:\(timerDisplayed)"
        timeStartSpeed = false
        timeStartPoint = false
        
        speed2x = false
        speed2xMove = true
        point2x = false
        point2xMove = true
    }
}
