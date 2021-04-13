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
    
    @IBOutlet weak var bomb1: UIImageView!
    @IBOutlet weak var bomb2: UIImageView!
    @IBOutlet weak var bomb3: UIImageView!
    
    @IBOutlet weak var timeSwitch: UISwitch!
    
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
        
//End Bomb Placement
        point2xImage.isHidden = true
        point2xImage.center = CGPoint(x: 0, y: 580)
        speed2xImage.isHidden = true
        speed2xImage.center = CGPoint(x: 300, y: 580)
        checkDirection()
        check2xSpeed()
        bombCheckTimerStart()
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
        bombCheckTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(bombCheckTimerAction), userInfo: nil, repeats: true)
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
        
        if speedCollected >= 5
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
            bombGameOver()
            print("bomb1 hit")
            
            bombCheckTimer.invalidate()
        }
        
        if characterImage.center == bomb2.center
        {
            bombGameOver()
            print("bomb2 hit")
            
            bombCheckTimer.invalidate()
        }
        
        if characterImage.center == bomb3.center
        {
            bombGameOver()
            print("bomb3 hit")
            
            bombCheckTimer.invalidate()
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

