//
//  LetsPlay.swift
//  Game of Minds v 0.01
//
//  Created by Dream on 25.10.19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit


class LetsPlay : UIViewController {
    
    @IBOutlet weak var testlabel: UILabel!
    @IBOutlet weak var chooseGameTimeButton: UIButton!
    
    var finishGameFlag = false
    var choosedType = 1
    
    
    @IBAction func settingsButton(_ sender: UIButton) {
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
            finishGameFlag = UserSettings.finishGameFlag
            if finishGameFlag {
                
                let fvc : UIViewController = (storyboard?.instantiateViewController(withIdentifier: "FinishGame"))!
                present(fvc, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        finishGameFlag = false
        UserSettings.finishGameFlag = false
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupGesture()
        
    }
    
    @IBAction func tappedMatchesButton(_ sender: UIButton) {
        
        self.choosedType = 1
        performSegue(withIdentifier: "startSegue", sender: nil)
        
    }
    
    @IBAction func tappedFlagsButton(_ sender: UIButton) {
        
        self.choosedType = 2
        performSegue(withIdentifier: "startSegue", sender: nil)
        
    }
    
    @IBAction func tappedColorsButton(_ sender: UIButton) {
        
        self.choosedType = 3
        performSegue(withIdentifier: "startSegue", sender: nil)
        
    }
    
    @IBAction func tappedMathButton(_ sender: UIButton) {
        
        self.choosedType = 4
        performSegue(withIdentifier: "startSegue", sender: nil)
        
    }
 
    private func setupGesture() {
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        chooseGameTimeButton.addGestureRecognizer(tapGesture)
    
    }
    
    @objc
    private func tapped() {
        
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "popVC") else { return }
        popVC.modalPresentationStyle = .popover
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.chooseGameTimeButton
        popOverVC?.sourceRect = CGRect(x: self.chooseGameTimeButton.bounds.midX, y: self.chooseGameTimeButton.bounds.maxY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 250, height: 200)
        
        self.present(popVC, animated: true, completion: nil)
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let dvc: Matches = segue.destination as? Matches else { return }
        dvc.choosedGameType = self.choosedType
        dvc.selectedGameTime = chooseGameTimeButton.title(for: .normal)

    }
    
    @IBAction func unwindToMainScreen(segue: UIStoryboardSegue) {
        
        guard segue.identifier == "unwindSegue" else { return }
        guard let svc = segue.source as? PopViewController else { return }
        self.chooseGameTimeButton.setTitle(svc.selectedElements == nil ? "No Limits" : svc.selectedElements, for: .normal)
    
    }

}


extension LetsPlay: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}





