//
//  ViewController.swift
//  WordleCheat
//
//  Created by Owen Flanagan on 4/25/22.
//

import UIKit

class ViewController: UIViewController {
    
    let remainingWords = remainingWord()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wordToGuess: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessResultTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var solvedLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor.black, radius: CGFloat(6.0), opacity: 1.0)
        
        submitButton.isEnabled = false
        
        remainingWords.resetWordList()
        
        updateUI()
        wordToGuess.text = "crane"
        errorLabel.alpha = 0
        solvedLabel.alpha = 0
        
    }
    
    func updateUI(){
        wordsRemainingLabel.text = String(remainingWords.numWords())
        wordToGuess.text = remainingWords.bestOption()
        guessTextField.text = ""
        guessResultTextField.text = ""
        if remainingWords.numWords() == 1{
            solvedLabel.alpha = 1
        }
        submitEnableCheck()
        if remainingWords.numWords() == remainingWords.initialWords.count {
            wordToGuess.text = "crane"
        }
        
    }
    
    func submitEnableCheck(){
        if guessTextField.text == nil || guessResultTextField.text == nil{
            submitButton.isEnabled = false
            return
        }
        
        if guessTextField.text!.isEmpty || guessResultTextField.text!.isEmpty {
            submitButton.isEnabled = false
        }
        else if guessTextField.text!.count == 5 && guessResultTextField.text!.count == 5{
            submitButton.isEnabled = true
        }
        else {
            submitButton.isEnabled = false
        }
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        errorLabel.alpha = 0
        let guess = guessTextField.text
        let guessResult = guessResultTextField.text
        if (!(guess!.count == 5) || !(guessResult!.count == 5)){
            errorLabel.alpha = 1
            return
        }
        for i in 0...4{
            if guessResult![i].uppercased() == "G"{
                remainingWords.eliminateOptionsGreen(letter: guess![i].lowercased(), position: i)
            }
            if guessResult![i].uppercased() == "Y"{
                remainingWords.eliminateOptionsYellow(letter: guess![i].lowercased(), position: i)
            }
            if guessResult![i].uppercased() == "R"{
                remainingWords.eliminateOptionsGrey(letter: guess![i].lowercased())
            }
        }
        guessTextField.text = ""
        guessResultTextField.text = ""
        updateUI()
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        errorLabel.alpha = 0
        solvedLabel.alpha = 0
        remainingWords.resetWordList()
        updateUI()
        wordToGuess.text = "crane"
        
    }
    
    @IBAction func guessTextChanged(_ sender: UITextField) {
        submitEnableCheck()
    }
    
    @IBAction func guessResultChanged(_ sender: UITextField) {
        submitEnableCheck()
    }

}

public extension String {
  subscript(value: Int) -> Character {
    self[index(at: value)]
  }
}

public extension String {
  subscript(value: NSRange) -> Substring {
    self[value.lowerBound..<value.upperBound]
  }
}

public extension String {
  subscript(value: CountableClosedRange<Int>) -> Substring {
    self[index(at: value.lowerBound)...index(at: value.upperBound)]
  }

  subscript(value: CountableRange<Int>) -> Substring {
    self[index(at: value.lowerBound)..<index(at: value.upperBound)]
  }

  subscript(value: PartialRangeUpTo<Int>) -> Substring {
    self[..<index(at: value.upperBound)]
  }

  subscript(value: PartialRangeThrough<Int>) -> Substring {
    self[...index(at: value.upperBound)]
  }

  subscript(value: PartialRangeFrom<Int>) -> Substring {
    self[index(at: value.lowerBound)...]
  }
}

private extension String {
  func index(at offset: Int) -> String.Index {
    index(startIndex, offsetBy: offset)
  }
}

extension UILabel {
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
           layer.masksToBounds = false
           layer.shadowOffset = offset
           layer.shadowColor = color.cgColor
           layer.shadowRadius = radius
           layer.shadowOpacity = opacity

           let backgroundCGColor = backgroundColor?.cgColor
           backgroundColor = nil
           layer.backgroundColor =  backgroundCGColor
       }
}
