//
//  ViewController.swift
//  WordleCheat
//
//  Created by Owen Flanagan on 4/25/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var wordList = [String]()
        let path = Bundle.main.path(forResource: "wordleWords.txt", ofType: nil)!
        let s = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        wordList = s.components(separatedBy: "\n")
        print ("wordList count = \(wordList.count)")
        print(wordList)
        
        let remainingWords = remainingWord()
        remainingWords.setWordList(words: wordList)
        
        
        
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
