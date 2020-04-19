//
//  BFOperation.swift
//  Week3TestWork
//
//  Created by Maxim on 2020. 04. 18..
//  Copyright © 2020. E-legion. All rights reserved.
//

import Foundation


class BruteForceOperation: Operation {
    
    private let passwordChar: Character
    private let characterArray = Consts.characterArray
    var result: String? {
        didSet {
            print("\(self.result ?? "#")")
            cancel()
        }
    }
    
    init(passwordChar: Character) {
        self.passwordChar = passwordChar
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        if characterArray.contains(String(passwordChar)) {
            result = String(passwordChar)
        } else {
            fatalError("no such character in password")
        }
        
    }
}
