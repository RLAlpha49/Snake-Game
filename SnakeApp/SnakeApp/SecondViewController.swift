//
//  SecondViewController.swift
//  SnakeApp
//
//  Created by Sarah Pettigrew on 1/20/21.
//

import UIKit
import AVKit
import AVFoundation

class SecondViewController: UIViewController {

    var playerViewController = AVPlayerViewController()
    var playerview = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playVideo(_ sender: UIButton)
    {
      //  if let url = URL(string: "")
       // {
        //    let player = AVPlayer(url: url)
       //     let controller = AVPlayerViewController()
       //     controller.player = player
        //    controller.view.frame = self.view.frame
         //   self.view.addSubview(controller.view)
         //   self.addChild(controller)
        //    player.play()
       // }
        
        
        let fileURL = URL(fileURLWithPath: "")
        playerview = AVPlayer(url: fileURL)
        
        playerViewController.player = playerview
        
        self.present(playerViewController, animated: true)
        {
            self.playerViewController.player?.play()
        }
    }
    
}
