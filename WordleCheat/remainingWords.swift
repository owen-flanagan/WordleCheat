//
//  remainingWords.swift
//  WordleCheat
//
//  Created by Owen Flanagan on 4/25/22.
//

import Foundation

class remainingWord {
   
    
    var wordList: [String] = []
    
    let letterFrequencies = ["A":43, "B": 11, "C":23, "D": 17, "E": 57, "F": 9, "G": 13, "H": 15, "I":38, "J":1,"K":6, "L":28, "M":15, "N":34, "O":37, "P":16, "Q":1, "R":39, "S":29, "T":35, "U":19, "V":5, "W":7, "X":1, "Y":9, "Z":1]
    //https://www3.nd.edu/~busiforc/handouts/cryptography/letterfrequencies.html
    
    func eliminateOptionsGreen(letter: String, position: Int){
        var temp: [String]
        temp = wordList.filter{String($0[position]) == letter}
        wordList = temp
    }
    
    func eliminateOptionsYellow(letter: String){
        var temp: [String]
        temp = wordList.filter{$0.contains(letter)}
        wordList = temp
    }
    
    func bestOption() -> String {
        var value = 0
        var bestWord = ""
        for word in wordList{
            var tempValue = 0
            var tempArray: [Character] = []
            for letter in word{
                if !(tempArray.contains(letter)) {
                    tempValue += letterFrequencies[(String(letter)).uppercased()]!
                }
                tempArray.append(letter)
            }
            if tempValue > value{
                bestWord = word
                value = tempValue
            }
        }
        return bestWord
    }
    
    func setWordList(words: [String]){
        wordList = words
    }
    
    func numWords() -> Int{
        return wordList.count
    }
}
