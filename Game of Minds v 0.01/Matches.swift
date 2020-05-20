//
//  Matches.swift
//  Game of Minds v 0.01
//
//  Created by Dream on 25.10.19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

class Matches : UIViewController {

    
    @IBOutlet weak var uiViewGameDesk: UIView!
    @IBOutlet weak var lTimer: UILabel!
    @IBOutlet weak var rightCounterLabel: UILabel!
    @IBOutlet weak var wrongCounterLabel: UILabel!
    @IBOutlet weak var NamesOfItem: UILabel!
    @IBOutlet weak var Item: UILabel!
    @IBOutlet weak var GameDesk: UIView!
    @IBOutlet weak var vObjectWithName: UIView!
    @IBOutlet weak var pauseTimerLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var mathLabel: UILabel!
    
    var timer = Timer()
    var seconds : Int? 
    var isTimerRunning = false
    var selectedGameTime : String?
    var pauseTimer : Int?
    
    var choosedGameType = 1
    var fruitsCount, animalsCount, thingsCount : Int?
    var finishGameFlag = false
    var currentResult: Int?
    var wrongResult: Int?
    
    private var arrayOfNames: [String] = []
    private var arrayOfImages: [String] = []
    private var isMatch: Bool = false


    
    @IBAction func pauseButton(_ sender: UIButton) {
        
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pauseVC") as! PopUpPauseViewController
        
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
        
        pauseTimer = seconds
        seconds = 999999
        lTimer.isHidden = true
        pauseTimerLabel.text = timeString(time: TimeInterval(pauseTimer!))
        guard selectedGameTime != "No Limits" else { return }
        pauseTimerLabel.isHidden = false

    }
    
    @IBAction func unwindToMainScreen(segue: UIStoryboardSegue) {
       
        if segue.identifier == "pauseSegue" {
        seconds = pauseTimer
        lTimer.text = pauseTimerLabel.text
        pauseTimerLabel.isHidden = true
        guard selectedGameTime != "No Limits" else { return }
        lTimer.isHidden = false
        } else if segue.identifier == "stopSegue" {
            seconds = 0
        } else { return }
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        currentResult = Int(rightCounterLabel.text!)!
        wrongResult = Int(wrongCounterLabel.text!)!
        UserSettings.currentResult = currentResult
        UserSettings.wrongResult = wrongResult
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        timer.invalidate()
        
    }
    
    func runTimer () {
        
        timer = Timer.scheduledTimer (timeInterval: 1, target: self, selector: (#selector(Matches.updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    func updateTimer () {
        
        if seconds! <= 10 {
            lTimer.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
       
        }
        if seconds! < 1 {
            finishGameFlag = true
            UserSettings.finishGameFlag = finishGameFlag
            dismiss(animated: true, completion: nil)
            } else {
                seconds! -= 1
                lTimer.text = timeString(time: TimeInterval(seconds!))
            }
        
    }
    
    func timeString(time:TimeInterval) -> String {
        
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
        
    }
    
    func randomNewPosition() {
        
        let screenSize = GameDesk.bounds
        let randomXPos = CGFloat(arc4random_uniform(UInt32(screenSize.width - 130)))
        let randomYPos = CGFloat(arc4random_uniform(UInt32(screenSize.height - 136)))
        vObjectWithName.frame = CGRect(x: randomXPos, y: randomYPos, width: 125, height: 131)
        
    }
    
    func checkAndAnimationCorrectResult() {
        
        if var rightCounter = Int(rightCounterLabel.text!) {
            rightCounter += 1
            rightCounterLabel.text = String(rightCounter)
            uiViewGameDesk.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            UIView.animate(withDuration: 0.5, animations: {
                self.uiViewGameDesk.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            })
        }
    }
    
    func checkCorrectResult() {
        
        if var rightCounter = Int(rightCounterLabel.text!) {
            rightCounter += 1
            rightCounterLabel.text = String(rightCounter)
        }
    }
    
    func checkAndAnimationWrongResult() {
            
        if var wrongCounter = Int(wrongCounterLabel.text!) {
            wrongCounter += 1
            wrongCounterLabel.text = String(wrongCounter)
            uiViewGameDesk.backgroundColor = #colorLiteral(red: 1, green: 0.1514827609, blue: 0.1277658045, alpha: 0.7088362069)
            UIView.animate(withDuration: 0.5, animations: {
                self.uiViewGameDesk.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            })
        }
    }
    
    func checkWrongResult() {
        
        if var wrongCounter = Int(wrongCounterLabel.text!) {
            wrongCounter += 1
            wrongCounterLabel.text = String(wrongCounter)
        }
    }
    
    func randomTrueOrFalseForMathType() {
        
        let mathOperationSelection = arc4random_uniform(UInt32(3))
        
        var firstOperand, secondOperand: Int?
        var thirdOperand: Int?
        
// MARK: random operation for operand "+" in Math type
        
        if mathOperationSelection == 0 {
            
            firstOperand = Int(arc4random_uniform(UInt32(100)) + 1)
            secondOperand = Int(arc4random_uniform(UInt32(100)) + 1)
            let correctCalculation = firstOperand! + secondOperand!
            
            let randomMatchTrueOrFalse = arc4random_uniform(UInt32(2))
            
            if randomMatchTrueOrFalse == 0 {
                
                if correctCalculation < 11 {
                   let differenceKoef = Int(arc4random_uniform(UInt32(1)) + 1)
                   let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                    if plusOrMinusKoef == 0 {
                        thirdOperand = correctCalculation + differenceKoef
                    } else {
                        thirdOperand = correctCalculation - differenceKoef
                    }
                }
                if correctCalculation > 10 && correctCalculation < 51 {
                    let differenceKoef = Int(arc4random_uniform(UInt32(5)) + 1)
                    let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                    if plusOrMinusKoef == 0 {
                        thirdOperand = correctCalculation + differenceKoef
                    } else {
                        thirdOperand = correctCalculation - differenceKoef
                    }
                }
                if correctCalculation > 50 && correctCalculation < 101 {
                    let differenceKoef = Int(arc4random_uniform(UInt32(9)) + 1)
                    let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                    if plusOrMinusKoef == 0 {
                        thirdOperand = correctCalculation + differenceKoef
                    } else {
                        thirdOperand = correctCalculation - differenceKoef
                    }
                }
                if correctCalculation > 100 && correctCalculation < 201 {
                    let differenceKoef = Int(arc4random_uniform(UInt32(14)) + 1)
                    let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                    if plusOrMinusKoef == 0 {
                        thirdOperand = correctCalculation + differenceKoef
                    } else {
                        thirdOperand = correctCalculation - differenceKoef
                    }
                }
                mathLabel.text = "\(Int(firstOperand!)) + \(Int(secondOperand!)) = \(Int(thirdOperand!))"
                isMatch = false
            } else {
                
                thirdOperand = firstOperand! + secondOperand!
                mathLabel.text = "\(Int(firstOperand!)) + \(Int(secondOperand!)) = \(Int(thirdOperand!))"
                isMatch = true
                
            }
        
        }
        
// MARK: random operation for operand "-" in Math type
        
        if mathOperationSelection == 1 {
                
                firstOperand = Int(arc4random_uniform(UInt32(198)) + 3)
                secondOperand = Int(arc4random_uniform(UInt32(firstOperand! - 2)) + 1)
                let correctCalculation = firstOperand! - secondOperand!
                
                let randomMatchTrueOrFalse = arc4random_uniform(UInt32(2))
                
                if randomMatchTrueOrFalse == 0 {
                    
                    if correctCalculation < 3 {
                        let differenceKoef = Int(arc4random_uniform(UInt32(1)) + 1)
                            thirdOperand = correctCalculation + differenceKoef
                        }
                    
                    if correctCalculation > 2 && correctCalculation < 11 {
                        let differenceKoef = Int(arc4random_uniform(UInt32(1)) + 1)
                        let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                        if plusOrMinusKoef == 0 {
                            thirdOperand = correctCalculation + differenceKoef
                        } else {
                            thirdOperand = correctCalculation - differenceKoef
                        }
                    }

                    if correctCalculation > 10 && correctCalculation < 51 {
                        let differenceKoef = Int(arc4random_uniform(UInt32(5)) + 1)
                        let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                        if plusOrMinusKoef == 0 {
                            thirdOperand = correctCalculation + differenceKoef
                        } else {
                            thirdOperand = correctCalculation - differenceKoef
                        }
                    }
                    if correctCalculation > 50 && correctCalculation < 101 {
                        let differenceKoef = Int(arc4random_uniform(UInt32(9)) + 1)
                        let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                        if plusOrMinusKoef == 0 {
                            thirdOperand = correctCalculation + differenceKoef
                        } else {
                            thirdOperand = correctCalculation - differenceKoef
                        }
                    }
                    if correctCalculation > 100 && correctCalculation < 201 {
                        let differenceKoef = Int(arc4random_uniform(UInt32(14)) + 1)
                        let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                        if plusOrMinusKoef == 0 {
                            thirdOperand = correctCalculation + differenceKoef
                        } else {
                            thirdOperand = correctCalculation - differenceKoef
                        }
                    }
                    mathLabel.text = "\(Int(firstOperand!)) - \(Int(secondOperand!)) = \(Int(thirdOperand!))"
                    isMatch = false
                } else {
                    
                    thirdOperand = firstOperand! - secondOperand!
                    mathLabel.text = "\(Int(firstOperand!)) - \(Int(secondOperand!)) = \(Int(thirdOperand!))"
                    isMatch = true
                    
                }
                
            }
        
// MARK: random operation for operand "*" in Math type
        
        if mathOperationSelection == 2 {
            
            firstOperand = Int(arc4random_uniform(UInt32(13)) + 1)
            secondOperand = Int(arc4random_uniform(UInt32(13)) + 1)
            let correctCalculation = firstOperand! * secondOperand!
            
            let randomMatchTrueOrFalse = arc4random_uniform(UInt32(2))
            
            if randomMatchTrueOrFalse == 0 {
                
                if correctCalculation < 11 {
                    let differenceKoef = Int(arc4random_uniform(UInt32(1)) + 1)
                    let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                    if plusOrMinusKoef == 0 {
                        thirdOperand = correctCalculation + differenceKoef
                    } else {
                        thirdOperand = correctCalculation - differenceKoef
                    }
                }
                if correctCalculation > 10 && correctCalculation < 51 {
                    let differenceKoef = Int(arc4random_uniform(UInt32(5)) + 1)
                    let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                    if plusOrMinusKoef == 0 {
                        thirdOperand = correctCalculation + differenceKoef
                    } else {
                        thirdOperand = correctCalculation - differenceKoef
                    }
                }
                if correctCalculation > 50 && correctCalculation < 101 {
                    let differenceKoef = Int(arc4random_uniform(UInt32(9)) + 1)
                    let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                    if plusOrMinusKoef == 0 {
                        thirdOperand = correctCalculation + differenceKoef
                    } else {
                        thirdOperand = correctCalculation - differenceKoef
                    }
                }
                if correctCalculation > 100 && correctCalculation < 201 {
                    let differenceKoef = Int(arc4random_uniform(UInt32(14)) + 1)
                    let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                    if plusOrMinusKoef == 0 {
                        thirdOperand = correctCalculation + differenceKoef
                    } else {
                        thirdOperand = correctCalculation - differenceKoef
                    }
                }
                mathLabel.text = "\(Int(firstOperand!)) * \(Int(secondOperand!)) = \(Int(thirdOperand!))"
                isMatch = false
            } else {
                
                thirdOperand = firstOperand! * secondOperand!
                mathLabel.text = "\(Int(firstOperand!)) * \(Int(secondOperand!)) = \(Int(thirdOperand!))"
                isMatch = true
                
            }
            
        }
        
// MARK: random operation for operand "/" in Math type
        
        if mathOperationSelection == 3 {
            
            firstOperand = Int(arc4random_uniform(UInt32(13)) + 1)
            secondOperand = Int(arc4random_uniform(UInt32(13)) + 1)
            let correctCalculation = firstOperand! * secondOperand!
            
            let randomMatchTrueOrFalse = arc4random_uniform(UInt32(2))
            
            if randomMatchTrueOrFalse == 0 {
                
                if correctCalculation < 11 {
                    let differenceKoef = Int(arc4random_uniform(UInt32(1)) + 1)
                    let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                    if plusOrMinusKoef == 0 {
                        thirdOperand = correctCalculation + differenceKoef
                    } else {
                        thirdOperand = correctCalculation - differenceKoef
                    }
                }
                if correctCalculation > 10 && correctCalculation < 51 {
                    let differenceKoef = Int(arc4random_uniform(UInt32(5)) + 1)
                    let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                    if plusOrMinusKoef == 0 {
                        thirdOperand = correctCalculation + differenceKoef
                    } else {
                        thirdOperand = correctCalculation - differenceKoef
                    }
                }
                if correctCalculation > 50 && correctCalculation < 101 {
                    let differenceKoef = Int(arc4random_uniform(UInt32(9)) + 1)
                    let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                    if plusOrMinusKoef == 0 {
                        thirdOperand = correctCalculation + differenceKoef
                    } else {
                        thirdOperand = correctCalculation - differenceKoef
                    }
                }
                if correctCalculation > 100 && correctCalculation < 201 {
                    let differenceKoef = Int(arc4random_uniform(UInt32(14)) + 1)
                    let plusOrMinusKoef = Int(arc4random_uniform(UInt32(2)))
                    if plusOrMinusKoef == 0 {
                        thirdOperand = correctCalculation + differenceKoef
                    } else {
                        thirdOperand = correctCalculation - differenceKoef
                    }
                }
                mathLabel.text = "\(Int(thirdOperand!)) / \(Int(secondOperand!)) = \(Int(firstOperand!))"
                isMatch = false
            } else {
                
                thirdOperand = firstOperand! * secondOperand!
                mathLabel.text = "\(Int(thirdOperand!)) / \(Int(secondOperand!)) = \(Int(firstOperand!))"
                isMatch = true
                
            }
            
        }


        
    }
    
    func randomTrueOrFalseForFlagsType() {
        
        let randomMatchTrueOrFalse = arc4random_uniform(UInt32(2))
        
        if randomMatchTrueOrFalse == 0 {
            
            let currentNameIndex = arc4random_uniform(UInt32(arrayOfNames.count))
            let currentImageIndex = arc4random_uniform(UInt32(arrayOfImages.count))
            NamesOfItem.text = arrayOfNames[Int(currentNameIndex)]
            Item.text = arrayOfImages[Int(currentImageIndex)]
            isMatch = currentNameIndex == currentImageIndex
            
        } else {
            
            let currentNameIndex = arc4random_uniform(UInt32(arrayOfNames.count))
            let currentImageIndex = currentNameIndex
            NamesOfItem.text = arrayOfNames[Int(currentNameIndex)]
            Item.text = arrayOfImages[Int(currentImageIndex)]
            isMatch = currentNameIndex == currentImageIndex
            
        }
    }
    
    func randomTrueOrFalseForColorType() {
        
        let red = UIColor.red
        let green = UIColor.green
        let blue = UIColor.blue
        let yellow = UIColor.yellow
        let orange = UIColor.orange
        let purple = UIColor.purple
        let gray = UIColor.gray
        let brown = UIColor.brown
        
        let arrayOfImages = [red, green, blue, yellow, orange, purple, gray, brown]
        let arrayOfNames = ["Red", "Green", "Blue", "Yellow", "Orange", "Purple", "Gray", "Brown"]
        
        let randomMatchTrueOrFalse = arc4random_uniform(UInt32(2))
        
        if randomMatchTrueOrFalse == 0 {
            
            let currentNameIndex = arc4random_uniform(UInt32(arrayOfNames.count))
            let currentImageIndex = arc4random_uniform(UInt32(arrayOfImages.count))
            colorLabel.text = arrayOfNames[Int(currentNameIndex)]
            uiViewGameDesk.backgroundColor = arrayOfImages[Int(currentImageIndex)]
            isMatch = currentNameIndex == currentImageIndex
            
        } else {
            
            let currentNameIndex = arc4random_uniform(UInt32(arrayOfNames.count))
            let currentImageIndex = currentNameIndex
            colorLabel.text = arrayOfNames[Int(currentNameIndex)]
            uiViewGameDesk.backgroundColor = arrayOfImages[Int(currentImageIndex)]
            isMatch = currentNameIndex == currentImageIndex
            
        }

        
    }
    
    func randomTrueOrFalseForMatchesType() {
        
        let randomMatchTrueOrFalse = arc4random_uniform(UInt32(2))
        
        if randomMatchTrueOrFalse == 0 {
            
            let currentNameIndex = arc4random_uniform(UInt32(arrayOfNames.count))
            switch Int(currentNameIndex) {
            case 1...fruitsCount!:
                let currentImageIndex = arc4random_uniform(UInt32(fruitsCount!))
                NamesOfItem.text = arrayOfNames[Int(currentNameIndex)]
                Item.text = arrayOfImages[Int(currentImageIndex)]
                isMatch = currentNameIndex == currentImageIndex
            case fruitsCount!...(fruitsCount! + thingsCount!):
                let currentImageIndex = arc4random_uniform(UInt32(thingsCount!))
                NamesOfItem.text = arrayOfNames[Int(currentNameIndex)]
                Item.text = arrayOfImages[Int(currentImageIndex) + fruitsCount!]
                isMatch = currentNameIndex == currentImageIndex
            case animalsCount!...(fruitsCount! + thingsCount! + animalsCount!):
                let currentImageIndex = arc4random_uniform(UInt32(animalsCount!))
                NamesOfItem.text = arrayOfNames[Int(currentNameIndex)]
                let sum = thingsCount! + fruitsCount!
                Item.text = arrayOfImages[Int(currentImageIndex) + sum]
                isMatch = currentNameIndex == currentImageIndex
            default:
                break
            }
            
        } else {
            
            let currentNameIndex = arc4random_uniform(UInt32(arrayOfNames.count))
            let currentImageIndex = currentNameIndex
            NamesOfItem.text = arrayOfNames[Int(currentNameIndex)]
            Item.text = arrayOfImages[Int(currentImageIndex)]
            isMatch = currentNameIndex == currentImageIndex
            
        }
    }
    
    func selectedGameType() {
        
        switch selectedGameTime! {
        case "No Limits" :
            UserSettings.gameType = "Matches, No Limits"
            seconds = 999999
            lTimer.isHidden = true
        case "30 sec" :
            UserSettings.gameType = "Matches, 30 sec"
            seconds = 30
            lTimer.isHidden = false
        case "1 min" :
            UserSettings.gameType = "Matches, 1 min"
            seconds = 60
            lTimer.isHidden = false
        case "2 min" :
            UserSettings.gameType = "Matches, 2 min"
            seconds = 120
            lTimer.isHidden = false
        case "10 min" :
            UserSettings.gameType = "Matches, 10 min"
            seconds = 600
            lTimer.isHidden = false
        default:
            break
        }
    }
    
    func prepareGameDeskAndLoadDate() {
        
// MARK: Load date for selected type Matches
        
        if choosedGameType == 1 {
            
            if let filepath = Bundle.main.path(forResource: "FruitsNames", ofType: "txt"),
                let contents = try? String(contentsOfFile: filepath) {
                arrayOfNames = contents.components(separatedBy: "\n")
                fruitsCount = arrayOfNames.count
            }
            
            if let filepath = Bundle.main.path(forResource: "FruitsImages", ofType: "txt"),
                let contents = try? String(contentsOfFile: filepath) {
                arrayOfImages = contents.components(separatedBy: "\n")
            }
            
            if let filepath = Bundle.main.path(forResource: "ThingsNames", ofType: "txt"),
                let contents = try? String(contentsOfFile: filepath) {
                arrayOfNames.append(contentsOf: contents.components(separatedBy: "\n"))
                thingsCount = arrayOfNames.count - fruitsCount!
            }
            
            if let filepath = Bundle.main.path(forResource: "ThingsImages", ofType: "txt"),
                let contents = try? String(contentsOfFile: filepath) {
                arrayOfImages.append(contentsOf: contents.components(separatedBy: "\n"))
            }
            
            if let filepath = Bundle.main.path(forResource: "AnimalsNames", ofType: "txt"),
                let contents = try? String(contentsOfFile: filepath) {
                arrayOfNames.append(contentsOf: contents.components(separatedBy: "\n"))
                animalsCount = arrayOfNames.count - fruitsCount! - thingsCount!
            }
            
            if let filepath = Bundle.main.path(forResource: "AnimalsImages", ofType: "txt"),
                let contents = try? String(contentsOfFile: filepath) {
                arrayOfImages.append(contentsOf: contents.components(separatedBy: "\n"))
            }
            
            randomTrueOrFalseForMatchesType()
            randomNewPosition()
            
        }
        
// MARK: Load date for selected type Flags
        
        if choosedGameType == 2 {
            
            if let filepath = Bundle.main.path(forResource: "FlagsNames", ofType: "txt"),
                let contents = try? String(contentsOfFile: filepath) {
                arrayOfNames = contents.components(separatedBy: "\n")
            }
            
            if let filepath = Bundle.main.path(forResource: "FlagsImages", ofType: "txt"),
                let contents = try? String(contentsOfFile: filepath) {
                arrayOfImages = contents.components(separatedBy: "\n")
            }
            
            randomTrueOrFalseForFlagsType()
            randomNewPosition()
            
        }
        
// MARK: Prepare desk for selected type Colors
        
        if choosedGameType == 3 {
            
            NamesOfItem.isHidden = true
            Item.isHidden = true
            colorLabel.isHidden = false
            randomTrueOrFalseForColorType()
        
        }
        
        if choosedGameType == 4 {
            
            NamesOfItem.isHidden = true
            Item.isHidden = true
            mathLabel.isHidden = false
            randomTrueOrFalseForMathType()
            
        }
        
        if choosedGameType == 4 {
            
            NamesOfItem.isHidden = true
            Item.isHidden = true
            mathLabel.isHidden = false
            randomTrueOrFalseForMathType()
            
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        currentResult = Int(rightCounterLabel.text!)!
        wrongResult = Int(wrongCounterLabel.text!)!
        UserSettings.currentResult = currentResult
        UserSettings.wrongResult = wrongResult
        
        selectedGameType()
        runTimer()
        prepareGameDeskAndLoadDate()
        
    }
    
    @IBAction func bCorrect(_ sender: Any) {
        
// MARK: tapped button CORRECT for Matches type
        
        if choosedGameType == 1 {
        
        if isMatch {
            checkAndAnimationCorrectResult()
        } else {
            checkAndAnimationWrongResult()
            }

        randomNewPosition()
        randomTrueOrFalseForMatchesType()
        
        }
        
// MARK: tapped button CORRECT for Flags type
        
        if choosedGameType == 2 {
            
            if isMatch {
                checkAndAnimationCorrectResult()
            } else {
                checkAndAnimationWrongResult()
                }
            
            randomNewPosition()
            randomTrueOrFalseForFlagsType()
        }
        
// MARK: tapped button CORRECT for Colors type
        
        if choosedGameType == 3 {
            
            if isMatch {
                checkCorrectResult()
            } else {
                checkWrongResult()
            }
            
            randomTrueOrFalseForColorType()
        }
        
// MARK: tapped button CORRECT for Math type
        
        if choosedGameType == 4 {
            
            if isMatch {
                checkAndAnimationCorrectResult()
            } else {
                checkAndAnimationWrongResult()
            }
            
            randomTrueOrFalseForMathType()
        }


    }
    
    @IBAction func bWrong(_ sender: Any) {
        
// MARK: tapped button WRONG for Matches type
        
        if choosedGameType == 1 {
        
        if !isMatch {
            checkAndAnimationCorrectResult()
        } else {
            checkAndAnimationWrongResult()
            }
        
        randomNewPosition()
        randomTrueOrFalseForMatchesType()
            
        }
        
// MARK: tapped button WRONG for Flags type
        
        if choosedGameType == 2 {
            
            if !isMatch {
                checkAndAnimationCorrectResult()
            } else {
                checkAndAnimationWrongResult()
            }
            
            randomNewPosition()
            randomTrueOrFalseForFlagsType()
        }
        
// MARK: tapped button WRONG for Colors type
        
        if choosedGameType == 3 {
            
            if !isMatch {
                checkCorrectResult()
            } else {
                checkWrongResult()
            }
            
            randomTrueOrFalseForColorType()
        }
        
// MARK: tapped button WRONG for Math type
        
        if choosedGameType == 4 {
            
            if !isMatch {
                checkAndAnimationCorrectResult()
            } else {
                checkAndAnimationWrongResult()
            }
            
            randomTrueOrFalseForMathType()
        }


    }
    
}
