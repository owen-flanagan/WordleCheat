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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var wordList = [String]()
        let path = Bundle.main.path(forResource: "wordleWords.txt", ofType: nil)!
        let s = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        wordList = s.components(separatedBy: "\n")
        print ("wordList count = \(wordList.count)")
        print(wordList)
        
        remainingWords.setWordList(words: wordList)
        
        updateUI()
        
    }
    
    func updateUI(){
        wordsRemainingLabel.text = String(remainingWords.numWords())
        wordToGuess.text = remainingWords.bestOption()
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
