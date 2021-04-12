//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Pettigrew, Alexander J on 2/8/21.
//  Copyright © 2021 Pettigrew, Alexander J. All rights reserved.
//

import UIKit

//NOTICE CAMERA & PHOTO LIBRARY DOES NOT SWITCH IMAGE

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//outlets
    @IBOutlet var images: [UIImageView]!
    @IBOutlet weak var pickedLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
//outlets
//let statements
    let imagePicker = UIImagePickerController()
    let randomRockImageArray = ["R1","R2"]
    let randomPaperImageArray = ["P1","P2"]
    let randomScissorsImageArray = ["S1","S2"]
    let url = URL(string: "https://www.wrpsa.com/the-official-rules-of-rock-paper-scissors/")
    let botChoiceArray = ["Rock", "Paper", "Scissors"]
//let statements
//var statements
    var image: [UIImage] = []
    var image1ImageSelected = false
    var image2ImageSelected = false
    var image3ImageSelected = false
    var photoLibraryTimer = Timer()
    var imageTimer = Timer()
    var gameTimer = Timer()
    var checkTimer = Timer()
    var picked = "Nothing"
    var timeLabel = 3
    var result = "Lose"
    var botChoice = ""
    var start = "False"
//var statements
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "Time: \(timeLabel)"
        
        image1.image = UIImage(named : "R1")
        image2.image = UIImage(named : "P1")
        image3.image = UIImage(named : "S1")
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        let botChoiceArray = ["Rock", "Paper", "Scissors"]
        botChoice = botChoiceArray.randomElement()!
        
        pickedLabel.text = "Picked:\(picked)"
        
        CheckImageTimer()
    }
// start gameover
    func gameOver()
    {
        checkTimer.invalidate()
        gameTimer.invalidate()
        
        let alert = UIAlertController(title: "Game Over", message: "You \(result)", preferredStyle: UIAlertController.Style.alert)
        
        let ok = UIAlertAction(title: "Reset", style: .default)
        {
            UIAlertAction in
            NSLog("Reset Pressed")
            self.Reset()
        }
       
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
//end game over
//start photolibrary
    func PhotoLibrary()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
//end photolibrary
//start camera
    func Camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
//end camera
//start cameraandphotolibrary
    func CameraAndPhotoLibrary()
    {
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let photoLibrary = UIAlertAction(title: "PhotoLibrary", style: .default)
        {
            UIAlertAction in
            NSLog("PhotoLibrary Pressed")
            self.PhotoLibrary()
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default)
        {
            UIAlertAction in
            NSLog("Camera Pressed")
            self.Camera()
        }
       
        alert.addAction(photoLibrary)
        alert.addAction(camera)
        
        present(imagePicker, animated: true, completion: nil)
    }
//end cameraandphotolibrary
//start checktimer
    func CheckTimer()
    {
        checkTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CheckAction),userInfo: nil, repeats: true)
    }
//end checktimer
//start checkaction
    @objc func CheckAction()
    {
        if timeLabel == 0
        {
            if picked == "Nothing"
            {
                gameOver()
            }
            
            if picked == "Rock"
            {
                checkTimer.invalidate()
                gameTimer.invalidate()
                
                if botChoice == "Rock"
                {
                    result = "Tie"
                    gameOver()
                }
                
                if botChoice == "Paper"
                {
                    result = "Lose"
                    gameOver()
                }
                
                if botChoice == "Scissors"
                {
                    result = "Win"
                    gameOver()
                }
            }
            
            if picked == "Paper"
            {
                checkTimer.invalidate()
                gameTimer.invalidate()
                
                if botChoice == "Rock"
                {
                    result = "Win"
                    gameOver()
                }
                
                if botChoice == "Paper"
                {
                    result = "Tie"
                    gameOver()
                }
                
                if botChoice == "Scissors"
                {
                    result = "Lose"
                    gameOver()
                }
            }
            
            if picked == "Sissors"
            {
                checkTimer.invalidate()
                gameTimer.invalidate()
                
                if botChoice == "Rock"
                {
                    result = "Lose"
                    gameOver()
                }
                
                if botChoice == "Paper"
                {
                    result = "Win"
                    gameOver()
                }
                
                if botChoice == "Scissors"
                {
                    result = "Tie"
                    gameOver()
                }
            }
        }
    }
//end checkaction
//start reset
    func Reset()
    {
        gameTimer.invalidate()
        
        image1ImageSelected = false
        image2ImageSelected = false
        image3ImageSelected = false
        picked = "Nothing"
        pickedLabel.text = "Picked: \(picked)"
        timeLabel = 3
        timerLabel.text = "Time: \(timeLabel)"
        botChoice = botChoiceArray.randomElement()!
        start = "False"
    }
//end reset
//start starttimer
    func StartTimer()
    {
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
    }
//end starttimer
//start action
    @objc func Action()
    {
        timeLabel -= 1
        timerLabel.text = "Time: \(timeLabel)"
    }
//end action
//start openrulesbutton
    @IBAction func openRulesButton(_ sender: UIButton)
    {
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
//end openrulesbutton
//start startbutton
    @IBAction func startButton(_ sender: Any)
    {
        StartTimer()
        CheckTimer()
        start = "True"
    }
//end startbutton
//start singletap
    @IBAction func singleTap(_ sender: UITapGestureRecognizer)
    {
        let selectedPoint = sender.location(in: view)
        
        print(selectedPoint)
        
        for imageView in images
        {
            if start == "True"
            {
                if imageView.frame.contains(selectedPoint)
                {
                    if imageView.tag == 1
                    {
                        print ("Image1Tapped")
                        picked = "Rock"
                        pickedLabel.text = "Picked:\(picked)"
                    }
                
                    if imageView.tag == 2
                    {
                        print ("Image2Tapped")
                        picked = "Paper"
                        pickedLabel.text = "Picked:\(picked)"
                    }
                
                    if imageView.tag == 3
                    {
                        print ("Image3Tapped")
                        picked = "Scissors"
                        pickedLabel.text = "Picked:\(picked)"
                    }
                
                    print("Single tap - Tag \(imageView.tag)")
                }
            }
        }
    }
//end singletap
//start doubletap
    @IBAction func doubledTap(_ sender: UITapGestureRecognizer)
    {
        let selectedPoint = sender.location(in: view)
        print(selectedPoint)
        for imageView in images
        {
            if start == "False"
            {
                if imageView.frame.contains(selectedPoint)
                {
                    if imageView.tag == 1
                    {
                        CameraAndPhotoLibrary()
                        image1ImageSelected = true
                        print("image1ImageSelected = true")
                    }
                    
                    if imageView.tag == 2
                    {
                        CameraAndPhotoLibrary()
                        image2ImageSelected = true
                        print("image2ImageSelected = true")
                    }
                    
                    if imageView.tag == 3
                    {
                        CameraAndPhotoLibrary()
                        image3ImageSelected = true
                        print("image3ImageSelected = true")
                    }
                    
                    print("Doubled tap - Tag \(imageView.tag)")
                }
            }
        }
    }
//end doubletap
//start checkimagetimer
    func CheckImageTimer()
    {
        imageTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkImageAction), userInfo: nil, repeats: true)
    }
//end checkimagetimer
//start checkimageaction
    @objc func checkImageAction()
    {
        if image1ImageSelected == true
        {
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
            {
                picker.dismiss(animated: true)
                {
                    self.image1.image = info[.originalImage] as? UIImage
                }
            }
        }
    
        if image2ImageSelected == true
        {
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
            {
                picker.dismiss(animated: true)
                {
                    self.image2.image = info[.originalImage] as? UIImage
                }
            }
        }
        
        if image3ImageSelected == true
        {
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
            {
                picker.dismiss(animated: true)
                {
                    self.image2.image = info[.originalImage] as? UIImage
                }
            }
        }
    }
//end checkimageaction
}
//NOTICE CAMERA & PHOTO LIBRARY DOES NOT SWITCH IMAGE

