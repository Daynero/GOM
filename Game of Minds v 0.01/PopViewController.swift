//
//  PopViewController.swift
//  Game of Minds v 0.01
//
//  Created by Dream on 15.03.20.
//  Copyright © 2020 Dream Team. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {
    
    @IBOutlet weak var elementPicker: UIPickerView!
    
    var uiElements = ["No Limits",
                      "30 sec",
                      "1 min",
                      "2 min",
                      "5 min",
                      "10 min"]
    
    var selectedElements: String?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        choiceUiElement()
        
    }
   
    @IBAction func okButton(_ sender: Any) {
        
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    
    }

    func choiceUiElement() {
        
        elementPicker.delegate = self
        
    }

}

extension PopViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedElements = uiElements[row]
        
    }
}
