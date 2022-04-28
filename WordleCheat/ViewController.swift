//
//  ViewController.swift
//  WordleCheat
//
//  Created by Owen Flanagan on 4/25/22.
//

import UIKit

class ViewController: UIViewController {
    
    let remainingWords = remainingWord()
    
    @IBOutlet weak var wordToGuess: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessResultTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remainingWords.resetWordList()
        
        updateUI()
        wordToGuess.text = "crane"
        errorLabel.alpha = 0
        
    }
    
    func updateUI(){
        wordsRemainingLabel.text = String(remainingWords.numWords())
        wordToGuess.text = remainingWords.bestOption()
        guessTextField.text = ""
        guessResultTextField.text = ""
        
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        errorLabel.alpha = 0
        let guess = guessTextField.text
        let guessResult = guessResultTextField.text
        if (!(guess!.count == 5) || !(guessResult!.count == 5)){
            errorLabel.alpha = 1
            
        }
        for i in 0...4{
            if guessResult![i].uppercased() == "G"{
                remainingWords.eliminateOptionsGreen(letter: guess![i].lowercased(), position: i)
            }
            if guessResult![i].uppercased() == "Y"{
                remainingWords.eliminateOptionsYellow(letter: guess![i].lowercased())
            }
        }
        guessTextField.text = ""
        guessResultTextField.text = ""
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        errorLabel.alpha = 0
        remainingWords.resetWordList()
        updateUI()
        wordToGuess.text = "crane"
        
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
