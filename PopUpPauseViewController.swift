//
//  PopUpPauseViewController.swift
//  Game of Minds v 0.01
//
//  Created by Dream on 08.04.20.
//  Copyright © 2020 Dream Team. All rights reserved.
//

import UIKit

class PopUpPauseViewController: UIViewController {
    
    var stopGameFlag = false
    
    @IBAction func resumeGame (_ sender: UIButton) {
        
        performSegue(withIdentifier: "pauseSegue", sender: nil)
        moveOut()
        
    }
    
    @IBAction func stopGame(_ sender: UIButton) {
        
        stopGameFlag = true
        UserSettings.finishGameFlag = stopGameFlag
        performSegue(withIdentifier: "stopSegue", sender: nil)
        moveOut()
        
    }
    
    func moveIn() {
        
        self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        self.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.24) {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0
        }
    }
    
    func moveOut() {
        
        UIView.animate(withDuration: 0.24, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            self.view.alpha = 0.0
        }) {
            _ in
            self.view.removeFromSuperview()
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        moveIn()
       
    }
 
}
