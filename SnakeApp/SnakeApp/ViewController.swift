//
//  ViewController.swift
//  SnakeApp
//
//  Created by Alex Pettigrew.
//
import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    var currentScore = 0
    var bestScore = 0
    
    var gameOverVar = false
    var check2xSpeedTimer = Timer()
    var gameTimer = Timer()
    var timerDisplayed = 60
    var timeStart = false
    var checkTimer = Timer()
    var speed2xTimer = Timer()
    var timeStartSpeed = false
    var point2xTimer = Timer()
    var timeStartPoint = false
    var checkDirectionTimer = Timer()
    var directionUp = false
    var directionDown = false
    var directionLeft = false
    var directionRight = false
    var checkSwitchTimer = Timer()
    var point2xValue = 0
    var speed2xValue = 0
    var speedCollectedTimer = Timer()
    var pointCollectedTimer = Timer()
    var speedCollected = 0
    var pointCollected = 0
    var bombCheckTimer = Timer()
    var extraLifeTimer = Timer()
    var extraLife = 0
    var extraLife1 = 0
    var extraLife2 = 0
    var extraLife3 = 0
    var extraLife4 = 0
    var extraLife5 = 0
    var lost = false
    var extraLifeLabelTimer = Timer()
    var extraLifeLost = false
    var extraLifeLabelOn = 0
    
    var snakeLength2 = false
    var snakeLength3 = false
    var snakeLength4 = false
    var snakeLength5 = false
    var snakeLength6 = false
    var snakeLength7 = false
    var snakeLength8 = false
    var snakeLength9 = false
    var snakeLength10 = false
    var checkSnakeLengthTimer = Timer()
    
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
    var speed2xMove = false
    var point2x = false
    var point2xMove = false
   
    var randomXLocation = 0
    var randomYLocation = 0
   
    let randomXArray = [1,5,9,13,17,21,25,29]
    let randomYArray = [1,5,9,13,17,21,25,29,33,37,41,45,49,53,57]
    
    let url = URL(string: "https://gfycat.com/waterloggedtanamberpenshell")
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var finishImageView: UIImageView!
    @IBOutlet weak var point2xImage: UIImageView!
    @IBOutlet weak var speed2xImage: UIImageView!

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeLabelOnOff: UILabel!
    @IBOutlet weak var extraLifeLabel: UILabel!
    
    @IBOutlet weak var bomb1: UIImageView!
    @IBOutlet weak var bomb2: UIImageView!
    @IBOutlet weak var bomb3: UIImageView!
    
    @IBOutlet weak var extraLifeImage: UIImageView!
    
    @IBOutlet weak var timeSwitch: UISwitch!
    
    @IBOutlet weak var snakeBody2: UIImageView!
    var snakeBody2LocationX = 0
    var snakeBody2LocationY = 0
    @IBOutlet weak var snakeBody3: UIImageView!
    var snakeBody3LocationX = 0
    var snakeBody3LocationY = 0
    @IBOutlet weak var snakeBody4: UIImageView!
    var snakeBody4LocationX = 0
    var snakeBody4LocationY = 0
    @IBOutlet weak var snakeBody5: UIImageView!
    var snakeBody5LocationX = 0
    var snakeBody5LocationY = 0
    @IBOutlet weak var snakeBody6: UIImageView!
    var snakeBody6LocationX = 0
    var snakeBody6LocationY = 0
    @IBOutlet weak var snakeBody7: UIImageView!
    var snakeBody7LocationX = 0
    var snakeBody7LocationY = 0
    @IBOutlet weak var snakeBody8: UIImageView!
    var snakeBody8LocationX = 0
    var snakeBody8LocationY = 0
    @IBOutlet weak var snakeBody9: UIImageView!
    var snakeBody9LocationX = 0
    var snakeBody9LocationY = 0
    @IBOutlet weak var snakeBody10: UIImageView!
    var snakeBody10LocationX = 0
    var snakeBody10LocationY = 0
    
    var playerViewController = AVPlayerViewController()
    var playerview = AVPlayer()
    
//Start ViewDidLoad
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        randomXRandomY()
        
        finishImageView.center = CGPoint(x: randomXLocation, y:randomYLocation)
        
        characterImage.center = CGPoint(x: x, y: y)
        
        if characterImage.center == finishImageView.center
        {
            randomXRandomY()
            
            finishImageView.center = CGPoint(x: randomXLocation, y:randomYLocation)
        }
//Start Bomb Placement
        
        randomXRandomY()
        
        bomb1.center = CGPoint(x: randomXLocation, y: randomYLocation)
        
        if bomb1.center == characterImage.center
        {
            randomXRandomY()
            
            bomb1.center = CGPoint(x: randomXLocation, y: randomYLocation)
            
            if bomb1.center == characterImage.center
            {
                randomXRandomY()
                
                bomb1.center = CGPoint(x: randomXLocation, y: randomYLocation)
            }
        }
        
        randomXRandomY()
        
        bomb2.center = CGPoint(x: randomXLocation, y: randomYLocation)
        
        if bomb2.center == characterImage.center
        {
            randomXRandomY()
            
            bomb1.center = CGPoint(x: randomXLocation, y: randomYLocation)
            
            if bomb2.center == characterImage.center
            {
                randomXRandomY()
                
                bomb1.center = CGPoint(x: randomXLocation, y: randomYLocation)
            }
        }
        
        randomXRandomY()
        
        bomb3.center = CGPoint(x: randomXLocation, y: randomYLocation)
        
        if bomb3.center == characterImage.center
        {
            randomXRandomY()
            
            bomb3.center = CGPoint(x: randomXLocation, y: randomYLocation)
            
            if bomb3.center == characterImage.center
            {
                randomXRandomY()
                
                bomb3.center = CGPoint(x: randomXLocation, y: randomYLocation)
            }
        }
        
//End Bomb Placement
        point2xImage.isHidden = true
        point2xImage.center = CGPoint(x: 0, y: 580)
        speed2xImage.isHidden = true
        speed2xImage.center = CGPoint(x: 300, y: 580)
        extraLifeImage.isHidden = true
        extraLifeImage.center = CGPoint(x: 0, y: 580)
        snakeBody2.isHidden = true
        snakeBody2.center = CGPoint(x: 150, y: 580)
        snakeBody3.isHidden = true
        snakeBody3.center = CGPoint(x: 150, y: 580)
        snakeBody4.isHidden = true
        snakeBody4.center = CGPoint(x: 150, y: 580)
        snakeBody5.isHidden = true
        snakeBody5.center = CGPoint(x: 150, y: 580)
        snakeBody6.isHidden = true
        snakeBody6.center = CGPoint(x: 150, y: 580)
        snakeBody7.isHidden = true
        snakeBody7.center = CGPoint(x: 150, y: 580)
        snakeBody8.isHidden = true
        snakeBody8.center = CGPoint(x: 150, y: 580)
        snakeBody9.isHidden = true
        snakeBody9.center = CGPoint(x: 150, y: 580)
        snakeBody10.isHidden = true
        snakeBody10.center = CGPoint(x: 150, y: 580)
        
        checkDirection()
        check2xSpeed()
        bombCheckTimerStart()
        extraLifeTimerStart()
        extraLifeLabelTimerStart()
        checkSnakeLengthTimerStart()
    }
    
//End ViewDidLoad
//Start Timers
    
    func timerStart()
    {
        timeStart = true
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
    }
    
    func timerStartSpeed()
    {
        timeStartSpeed = true
        
        speed2xTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SpeedAction), userInfo: nil, repeats: true)
    }
    
    func timerStartPoint()
    {
        timeStartPoint = true
        
        point2xTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PointAction), userInfo: nil, repeats: true)
    }
    
    func check2xSpeed()
    {
        check2xSpeedTimer = Timer.scheduledTimer(timeInterval: 0.20, target: self, selector: #selector(Check2xSpeedAction), userInfo: nil, repeats: true)
    }
    
    func checkDirection()
    {
        checkDirectionTimer = Timer.scheduledTimer(timeInterval: 0.40, target: self, selector: #selector(CheckDirectionAction), userInfo: nil, repeats: true)
    }
   
    func speedPowerUpSpawned()
    {
        speedCollectedTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(speedPowerUpSpawnedAction), userInfo: nil, repeats: true)
    }
    
    func pointPowerUpSpawned()
    {
        pointCollectedTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(pointPowerUpSpawnedAction), userInfo: nil, repeats: true)
    }
    
    func bombCheckTimerStart()
    {
        bombCheckTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(bombCheckTimerAction), userInfo: nil, repeats: true)
    }
    
    func extraLifeTimerStart()
    {
        extraLifeTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(extraLifeTimerAction), userInfo: nil, repeats: true)
    }
    
    func extraLifeLabelTimerStart()
    {
        extraLifeLabelTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(extraLifeLabelTimerAction), userInfo: nil, repeats: true)
    }
    
    func checkSnakeLengthTimerStart()
    {
        checkSnakeLengthTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(checkSnakeLengthAction), userInfo: nil, repeats: true)
    }
    
//End Timers
//Start Timer Actions
    
    @objc func Action()
    {
        if timeSwitch.isOn == true
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
    }

    @objc func SpeedAction()
    {
        speed2xPowerUp()
        
        if speed2x == true
        {
            speed2xTimer.invalidate()
        }
    }
    
    @objc func PointAction()
    {
        point2xPowerUp()
        
        if point2x == true
        {
            point2xTimer.invalidate()
        }
    }
    
    @objc func Check2xSpeedAction()
    {
        if speed2x == true
        {
            speed2xImage.isHidden = true
            checkDirectionTimer.invalidate()
            direction()
        }
    }
    
    @objc func CheckDirectionAction()
    {
        direction()
        
        if gameOverVar == true
        {
            directionUp = false
            directionDown = false
            directionLeft = false
            directionRight = false
        }
    }
    
    @objc func speedPowerUpSpawnedAction()
    {
        speedCollected += 1
        
        if speedCollected >= 10
        {
            speedCollectedTimer.invalidate()
            speed2xImage.isHidden = true
            speed2xImage.center = CGPoint(x: 300, y: 580)
        }
    }
  
    @objc func pointPowerUpSpawnedAction()
    {
        pointCollected += 1
        
        if pointCollected >= 5
        {
            pointCollectedTimer.invalidate()
            point2xImage.isHidden = true
            point2xImage.center = CGPoint(x: 0, y: 500)
        }
    }
    
    @objc func bombCheckTimerAction()
    {
        if characterImage.center == bomb1.center
        {
            if lost == false
            {
                if extraLife == 0
                {
                    bombGameOver()
                    print("bomb1 hit")
                    
                    lost = true
                        
                    bombCheckTimer.invalidate()
                }
            }
            
            extraLife -= 1
            extraLifeLost = true
            print("extraLifeLost")
        }
            
        if characterImage.center == bomb2.center
        {
            if lost == false
            {
                if extraLife == 0
                {
                    bombGameOver()
                    print("bomb1 hit")
                    
                    lost = true
                    
                    bombCheckTimer.invalidate()
                }
            }
            
            extraLife -= 1
            extraLifeLost = true
            print("extraLifeLost")
        }
        
        if characterImage.center == bomb3.center
        {
            if lost == false
            {
                if extraLife <= 0
                {
                    bombGameOver()
                    print("bomb1 hit")
                    
                    lost = true
                    
                    bombCheckTimer.invalidate()
                }
            }
                
            extraLife -= 1
            extraLifeLost = true
            print("extraLifeLost")
        }
    }
    
    @objc func extraLifeTimerAction()
    {
        if extraLife1 == 0
        {
            if currentScore >= 5 && currentScore <= 10
            {
                randomXRandomY()
                
                extraLifeImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
                
                extraLifeImage.isHidden = false
                
                extraLife1 += 1
                print("extraLife1 = 1")
            }
        }
        
        if extraLife2 == 0
        {
            if currentScore >= 10 && currentScore <= 15
            {
                randomXRandomY()
                
                extraLifeImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
                
                extraLifeImage.isHidden = false
                
                extraLife2 += 1
                print("extraLife2 = 1")
            }
        }
        
        if extraLife3 == 0
        {
            if currentScore >= 15 && currentScore <= 20
            {
                randomXRandomY()
                
                extraLifeImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
                
                extraLifeImage.isHidden = false
                
                extraLife3 += 1
                print("extraLife3 = 1")
            }
        }
        
        if extraLife4 == 0
        {
            if currentScore >= 20 && currentScore <= 25
            {
                randomXRandomY()
                
                extraLifeImage.center = CGPoint(x: randomXLocation, y: y)
                
                extraLifeImage.isHidden = false
                
                extraLife4 += 1
                print("extraLife4 = 1")
            }
        }
        
        if extraLife5 == 0
        {
            if currentScore >= 25 && currentScore <= 30
            {
                randomXRandomY()
                
                extraLifeImage.center = CGPoint(x: x, y: y)
                
                extraLifeImage.isHidden = false
                
                extraLife5 += 1
                print("extraLife5 = 1")
            }
        }
    }
    
    @objc func extraLifeLabelTimerAction()
    {
        if extraLifeLost == true
        {
            extraLifeLabel.text = "Life Lost\n\(extraLife) Extra Lives Remaining"
            
            extraLifeLabelOn += 1
        }
        
        if extraLifeLabelOn >= 5
        {
            extraLifeLabelTimer.invalidate()
            extraLifeLabel.text = ""
        }
    }
    
    @objc func checkSnakeLengthAction()
    {
        if snakeLength2 == true
        {
            if speed2x == true
            {
                if directionUp == true
                {
                    snakeBody2LocationX = x
                    snakeBody2LocationY = y + 15
                    snakeBody2.center = CGPoint(x: snakeBody2LocationX, y: snakeBody2LocationY)
                }
                else
                {
                    if directionDown == true
                    {
                        snakeBody2LocationX = x
                        snakeBody2LocationY = y - 15
                        snakeBody2.center = CGPoint(x: snakeBody2LocationX, y: snakeBody2LocationY)
                    }
                    else
                    {
                        if directionLeft == true
                        {
                            snakeBody2LocationX = x + 15
                            snakeBody2LocationY = y
                            snakeBody2.center = CGPoint(x: snakeBody2LocationX, y: snakeBody2LocationY)
                        }
                        else
                        {
                            if directionRight == true
                            {
                                snakeBody2LocationX = x + 15
                                snakeBody2LocationY = y
                                snakeBody2.center = CGPoint(x: snakeBody2LocationX, y: snakeBody2LocationY)
                            }
                        }
                    }
                }
            }
            else
            {
                if directionUp == true
                {
                    snakeBody2LocationX = x
                    snakeBody2LocationY = y + 15
                    snakeBody2.center = CGPoint(x: snakeBody2LocationX, y: snakeBody2LocationY)
                }
                else
                {
                    if directionDown == true
                    {
                        snakeBody2LocationX = x
                        snakeBody2LocationY = y - 15
                        snakeBody2.center = CGPoint(x: snakeBody2LocationX, y: snakeBody2LocationY)
                    }
                    else
                    {
                        if directionLeft == true
                        {
                            snakeBody2LocationX = x + 15
                            snakeBody2LocationY = y
                            snakeBody2.center = CGPoint(x: snakeBody2LocationX, y: snakeBody2LocationY)
                        }
                        else
                        {
                            if directionRight == true
                            {
                                snakeBody2LocationX = x + 15
                                snakeBody2LocationY = y
                                snakeBody2.center = CGPoint(x: snakeBody2LocationX, y: snakeBody2LocationY)
                            }
                        }
                    }
                }
            }
            snakeBody2.isHidden = false
        }
        
        if snakeLength3 == true
        {
            if speed2x == true
            {
                if directionUp == true
                {
                
                }
                
                if directionDown == true
                {
                    
                }
                
                if directionRight == true
                {
                    
                }
                
                if directionLeft == true
                {
                    
                }
            }
            else
            {
                if directionUp == true
                {
                
                }
                
                if directionDown == true
                {
                    
                }
                
                if directionRight == true
                {
                    
                }
                
                if directionLeft == true
                {
                    
                }
            }
            snakeBody3.isHidden = false
        }
        
        if snakeLength4 == true
        {
            if speed2x == true
            {
                
            }
            else
            {
                
            }
            snakeBody4.isHidden = false
        }
        
        if snakeLength5 == true
        {
            if speed2x == true
            {
                
            }
            else
            {
                
            }
            snakeBody5.isHidden = false
        }
        
        if snakeLength6 == true
        {
            if speed2x == true
            {
                
            }
            else
            {
                
            }
            snakeBody6.isHidden = false
        }
        
        if snakeLength7 == true
        {
            if speed2x == true
            {
                
            }
            else
            {
                
            }
            snakeBody7.isHidden = false
        }
        
        if snakeLength8 == true
        {
            if speed2x == true
            {
                
            }
            else
            {
                
            }
            snakeBody8.isHidden = false
        }
        
        if snakeLength9 == true
        {
            if speed2x == true
            {
                
            }
            else
            {
                
            }
            snakeBody9.isHidden = false
        }
        
        if snakeLength10 == true
        {
            if speed2x == true
            {
                
            }
            else
            {
                
            }
            snakeBody10.isHidden = false
        }
    }
    
//End Timer Actions
//Start Functions
    
    func gameOver()
    {
        gameOverVar = true
        
        directionLeft = false
        directionRight = false
        directionDown = false
        directionUp = false
        
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
    
    func bombGameOver()
    {
        print("bombGamerOver Function")
        
        gameOverVar = true
        
        directionLeft = false
        directionRight = false
        directionDown = false
        directionUp = false
        
        gameTimer.invalidate()
        
        speed2xImage.isHidden = true
        point2xImage.isHidden = true
        
        if bestScore < currentScore
        {
            bestScore = currentScore
        }
        
        let alert = UIAlertController(title: "You Were Bombed\nGame Over", message: "Best Score:\(bestScore)", preferredStyle: UIAlertController.Style.alert)
        
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
        randomXRandomY()
        
        finishImageView.center = CGPoint(x: randomXLocation, y:randomYLocation)
        
        randomXRandomY()
        
        bomb1.center = CGPoint(x: randomXLocation, y: randomYLocation)
        
        if bomb1.center == characterImage.center
        {
            randomXRandomY()
            
            bomb1.center = CGPoint(x: randomXLocation, y: randomYLocation)
        }
        
        randomXRandomY()
        
        bomb2.center = CGPoint(x: randomXLocation, y: randomYLocation)
        
        if bomb2.center == characterImage.center
        {
            randomXRandomY()
            
            bomb1.center = CGPoint(x: randomXLocation, y: randomYLocation)
        }
        
        randomXRandomY()
        
        bomb3.center = CGPoint(x: randomXLocation, y: randomYLocation)
        
        if bomb3.center == characterImage.center
        {
            randomXRandomY()
            
            bomb3.center = CGPoint(x: randomXLocation, y: randomYLocation)
        }
        
        x = 10
        y = 10
        
        characterImage.center = CGPoint(x: x, y: y)
        
        currentScore = 0
        scoreLabel.text = "Score:\(currentScore)"
        timerDisplayed = 60
        timeLabel.text = "Time:\(timerDisplayed)"
        timeStart = false
        timeStartSpeed = false
        timeStartPoint = false
        
        speed2x = false
        speed2xMove = true
        point2x = false
        point2xMove = true
        speedCollected = 0
        pointCollected = 0
        
        directionLeft = false
        directionRight = false
        directionDown = false
        directionUp = false
        gameOverVar = false
        
        speed2xImage.isHidden = true
        point2xImage.isHidden = true
        extraLifeImage.isHidden = true
        bombCheckTimerStart()
    }
    
    func direction()
    {
        if directionUp == true
        {
            directionDown = false
            directionLeft = false
            directionRight = false
            
            if y <= 15
            {
                gameOver()
                
                directionDown = false
                directionUp = false
                directionLeft = false
                directionRight = false
            }
        
            y += upButton
        
            characterImage.center = CGPoint(x: x, y: y)
            
            pointAdd()
            speed2xPowerUpActive()
            point2xPowerUpActive()
        }
        
        if directionDown == true
        {
            directionUp = false
            directionLeft = false
            directionRight = false
            
            if y >= 570
            {
                gameOver()
                
                directionDown = false
                directionUp = false
                directionLeft = false
                directionRight = false
            }
            
            y += downButton
            
            characterImage.center = CGPoint(x: x, y: y)
            
            pointAdd()
            speed2xPowerUpActive()
            point2xPowerUpActive()
        }
        
        if directionRight == true
        {
            directionDown = false
            directionUp = false
            directionLeft = false
            
            if x >= 285
            {
                gameOver()
                
                directionDown = false
                directionUp = false
                directionLeft = false
                directionRight = false
            }
            
            x += rightButton
            
            characterImage.center = CGPoint(x: x, y: y)
            
            pointAdd()
            speed2xPowerUpActive()
            point2xPowerUpActive()
        }
        
        if directionLeft == true
        {
            directionDown = false
            directionUp = false
            directionRight = false
            
            if x <= 15
            {
                gameOver()
                
                directionDown = false
                directionUp = false
                directionLeft = false
                directionRight = false
            }
            
            x += leftButton
            
            characterImage.center = CGPoint(x: x, y: y)
            
            pointAdd()
            speed2xPowerUpActive()
            point2xPowerUpActive()
        }
    }
    
    func randomXRandomY()
    {
        randomXLocation = randomXArray.randomElement()! * 10
        randomYLocation = randomYArray.randomElement()! * 10
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
        
        if characterImage.center == extraLifeImage.center
        {
            extraLife += 1
            print("extraLife Plus 1")
            
            extraLifeImage.isHidden = true
            
            randomXRandomY()
            bomb1.center = CGPoint(x: randomXLocation, y: randomYLocation)
            
            randomXRandomY()
            bomb2.center = CGPoint(x: randomXLocation, y: randomYLocation)
            
            randomXRandomY()
            bomb3.center = CGPoint(x: randomXLocation, y: randomYLocation)
            
            
        }
        
        
    }
    
    func speed2xPowerUp()
    {
        if speed2xValue == 0
        {
            if speed2xMove == false
            {
                if currentScore >= 2
                {
                    speed2xMove = true
                }
            }
            else
            {
                randomXRandomY()
                
                speed2xImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
                
                if speed2xImage.center == characterImage.center
                {
                    randomXRandomY()
                    
                    speed2xImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
                }
                
                if speed2xImage.center == finishImageView.center
                {
                    randomXRandomY()
                    
                    speed2xImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
                }
                
                if speed2xImage.center != CGPoint(x: 0, y: 580)
                {
                    speed2xMove = false
                    speed2xImage.isHidden = false
                    speedPowerUpSpawned()
                }
                
                speed2xValue = 1
            }
        }
    }
    
    func point2xPowerUp()
    {
        if point2xValue == 0
        {
            if point2xMove == false
            {
                if currentScore >= 8
                {
                    point2xMove = true
                }
            }
            else
            {
                randomXRandomY()
                
                point2xImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
                
                if point2xImage.center == characterImage.center
                {
                    randomXRandomY()
                    
                    point2xImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
                }
                
                if point2xImage.center == finishImageView.center
                {
                    randomXRandomY()
                    
                    point2xImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
                }
                
                if point2xImage.center != CGPoint(x: 300, y: 580)
                {
                    point2xMove = false
                    point2xImage.isHidden = false
                    pointPowerUpSpawned()
                }
                
                point2xValue = 1
            }
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
    
//End Functions
//Start @IBAction Functions
    //Start Directional Pad Buttons
    
        @IBAction func upButton(_ sender: Any)
        {
            directionUp = true
            directionDown = false
            directionRight = false
            directionLeft = false

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
        }

        @IBAction func downButton(_ sender: Any)
        {
            directionUp = false
            directionDown = true
            directionRight = false
            directionLeft = false

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
        }

        @IBAction func rightButton(_ sender: Any)
        {
            directionUp = false
            directionDown = false
            directionRight = true
            directionLeft = false

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
        }

        @IBAction func switchTimer(_ sender: Any)
        {
            CheckSwitchAction()
        }
    
        @IBAction func leftButton(_ sender: Any)
        {
            directionUp = false
            directionDown = false
            directionRight = false
            directionLeft = true

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
        }
    
    //End Directional Pad Buttons
  
    @IBAction func secretButton(_ sender: Any)
    {
        print("secret pressed")
        
        if bestScore >= 20
        {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Not Unlocked", message: "", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            {
                UIAlertAction in
                NSLog("OK Pressed")
            }
            
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
//End @IBAction Functions
//Start Arrow Keybinds
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?)
    {
        var didHandleEvent = false
        
        for press in presses
        {
            guard let key = press.key else { continue }
            
            if key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow
            {
                didHandleEvent = false
                if gameOverVar == false
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
                    
                    if directionRight == true
                    {
                        directionLeft = false
                        directionUp = false
                        directionDown = false
                    }
                    else
                    {
                        directionDown = false
                        directionUp = false
                        directionRight = false
                        directionLeft = true
                    }
                }
                
                didHandleEvent = true
            }
            
            if key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow
            {
                didHandleEvent = false
                
                if gameOverVar == false
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
                    
                    if directionLeft == true
                    {
                        directionUp = false
                        directionDown = false
                        directionRight = false
                    }
                    else
                    {
                        directionDown = false
                        directionUp = false
                        directionLeft = false
                        directionRight = true
                    }
                }
               
                didHandleEvent = true
            }
            
            if key.charactersIgnoringModifiers == UIKeyCommand.inputUpArrow
            {
                didHandleEvent = false
                
                if gameOverVar == false
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
                    
                    if directionDown == true
                    {
                        directionUp = false
                        directionLeft = false
                        directionRight = false
                    }
                    else
                    {
                        directionDown = false
                        directionLeft = false
                        directionRight = false
                        directionUp = true
                    }
                }
                
                didHandleEvent = true
            }
            
            if key.charactersIgnoringModifiers == UIKeyCommand.inputDownArrow
            {
                didHandleEvent = false
                
                if gameOverVar == false
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
                    
                    if directionUp == true
                    {
                        directionDown = false
                        directionLeft = false
                        directionRight = false
                    }
                    else
                    {
                        directionUp = false
                        directionLeft = false
                        directionRight = false
                        directionDown = true
                    }
                }
                
                didHandleEvent = true
            }
        }
        
        if didHandleEvent == false
        {
            super.pressesBegan(presses, with: event)
        }
    }
    
//End Arrow Keybinds
//Start Other
   
    //One Thousand!!!
    @objc func CheckSwitchAction()
    {
        print("SwitchTimerOn")
        if timeSwitch.isOn == true
        {
            timeLabelOnOff.text = "Time On"
        }
        else
        {
            timeLabelOnOff.text = "Time Off"
        }
    }
    
//End Other
}

