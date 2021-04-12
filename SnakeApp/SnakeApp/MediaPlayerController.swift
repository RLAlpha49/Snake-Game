//
//  MediaPlayerController.swift
//  SnakeApp
//
//  Created by Pettigrew, Alexander J on 3/26/21.
//

import UIKit
import AVKit
import AVFoundation


class MediaPlayerViewController: UIViewController {

    var playerViewController = AVPlayerViewController()
    var playerview = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .moviePlayback)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        return true
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        guard let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8") else {
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)

        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player

        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }
    }
    
//    @IBAction func playVideo(_ sender: UIButton)
//    {
//       if let url = URL(string: "")
//        {
//           let player = AVPlayer(url: url)
//           let controller = AVPlayerViewController()
//           controller.player = player
//           controller.view.frame = self.view.frame
//          self.view.addSubview(controller.view)
//         self.addChild(controller)
//            player.play()
//      }
//
//        let fileURL = URL(fileURLWithPath: "")
//        playerview = AVPlayer(url: fileURL)
//
//        playerViewController.player = playerview
//
//        self.present(playerViewController, animated: true)
//        {
//            self.playerViewController.player?.play()
//        }
//    }
//}

}
