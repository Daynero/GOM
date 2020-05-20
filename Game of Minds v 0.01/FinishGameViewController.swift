//
//  FinishGameViewController.swift
//  Game of Minds v 0.01
//
//  Created by Dream on 09.04.20.
//  Copyright © 2020 Dream Team. All rights reserved.
//

import UIKit

class FinishGameViewController: UIViewController {
    
    @IBOutlet weak var aboutGameTypeLabel: UILabel!
    @IBOutlet weak var badJobLabel: UILabel!
    @IBOutlet weak var wrongResultLabel: UILabel!
    @IBOutlet weak var rightResultLabel: UILabel!
    @IBOutlet weak var goodJobLabel: UILabel!
    
    var currentResult: Int?
    var wrongResult: Int?
    
    @IBAction func tryAgainButtonPressed(_ sender: UIButton) {
    }
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        
        UserSettings.finishGameFlag = false
        dismiss(animated: true, completion: nil)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        currentResult = UserSettings.currentResult
        wrongResult = UserSettings.wrongResult
        aboutGameTypeLabel.text = UserSettings.gameType
        rightResultLabel.text = String(currentResult!)
        wrongResultLabel.text = String(wrongResult!)
        if currentResult! > wrongResult! {
           badJobLabel.isHidden = true
           goodJobLabel.isHidden = false
        }
    
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()        
        
            }

}
