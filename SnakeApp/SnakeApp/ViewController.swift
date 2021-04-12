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
    
    let url = URL(string: "https://gfycat.com/waterloggedtanamberpenshell")
    
    let randomXArray = [1,5,9,13,17,21,25,29]
    
    let randomYArray = [1,5,9,13,17,21,25,29,33,37,41,45,49,53,57]
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var finishImageView: UIImageView!
    
    @IBOutlet weak var point2xImage: UIImageView!
    
    @IBOutlet weak var speed2xImage: UIImageView!
    
    @IBOutlet weak var timeSwitch: UISwitch!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
   
    @IBOutlet weak var timeLabelOnOff: UILabel!
    
    @IBOutlet weak var secretButton: UIBarButtonItem!
    
    var playerViewController = AVPlayerViewController()
    var playerview = AVPlayer()
    
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
        checkDirection()
        check2xSpeed()
        
        //secretButton.isEnabled = false
    }
    
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
        if speed2xValue == 0
        {
            if speed2xMove == false
            {
                if currentScore >= 2
                {
                   // speed2xImage.isHidden = false
                    speed2xMove = true
                }
            }
            else
            {
                randomXLocation = randomXArray.randomElement()! * 10
                randomYLocation = randomYArray.randomElement()! * 10
                
                speed2xImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
                
                if speed2xImage.center != CGPoint(x: 0, y: 580)
                {
                    speed2xMove = false
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
                    //point2xImage.isHidden = false
                    point2xMove = true
                }
            }
            else
            {
                randomXLocation = randomXArray.randomElement()! * 10
                randomYLocation = randomYArray.randomElement()! * 10
                
                point2xImage.center = CGPoint(x: randomXLocation, y: randomYLocation)
                
                if point2xImage.center != CGPoint(x: 300, y: 580)
                {
                    point2xMove = false
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
        
        if bestScore >= 20
        {
            //secretButton.isEnabled = true
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
        
        directionLeft = false
        directionRight = false
        directionDown = false
        directionUp = false
        gameOverVar = false
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
    
    func check2xSpeed()
    {
        check2xSpeedTimer = Timer.scheduledTimer(timeInterval: 0.20, target: self, selector: #selector(Check2xSpeedAction), userInfo: nil, repeats: true)
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
    
    func checkDirection()
    {
        checkDirectionTimer = Timer.scheduledTimer(timeInterval: 0.40, target: self, selector: #selector(CheckDirectionAction), userInfo: nil, repeats: true)
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
            
//                    directionRight = false
//                    directionDown = false
//                    directionUp = false
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
                    
    //                directionLeft = false
    //                directionDown = false
    //                directionUp = false
                   
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
                    
    //                directionDown = false
    //                directionLeft = false
    //                directionRight = false
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
                
    //                directionUp = false
    //                directionLeft = false
    //                directionRight = false
                }
                
                didHandleEvent = true
            }
        }
        
        if didHandleEvent == false {
            // Didn't handle this key press, so pass the event to the next responder.
            super.pressesBegan(presses, with: event)
        }
    }
    
    @IBAction func secretButton(_ sender: Any)
    {
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            try audioSession.setCategory(.playback, mode: .moviePlayback)
//        }
//        catch {
//            print("Setting category to AVAudioSessionCategoryPlayback failed.")
//        }
//        return true
    
//        guard let url = URL(string: "https://gfycat.com/waterloggedtanamberpenshell") else {
//            return
//        }
//        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
//        let player = AVPlayer(url: url)
//
//        // Create a new AVPlayerViewController and pass it a reference to the player.
//        let controller = AVPlayerViewController()
//        controller.player = player
//
//        // Modally present the player and call the player's play() method when complete.
//        present(controller, animated: true) {
//            player.play()
//        }
    }

