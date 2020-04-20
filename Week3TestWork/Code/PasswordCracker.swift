//
//  PasswordCracker.swift
//  Week3TestWork
//
//  Created by Maxim on 2020. 04. 18..
//  Copyright © 2020. E-legion. All rights reserved.
//

import Foundation

/**
 Функционал поиска пароля полностью вынесен из ViewController. В переопределенном инициализаторе задаются свойства OperationQueue.
 */
class PasswordQueue: OperationQueue {
    
    override init() {
        super.init()
        qualityOfService = .userInitiated
    }
    
    typealias QueueHandler = ((String, String) -> ())?
    
    /**
     Основной рабочий метод класса
     
     - Parameters:
        - password: принимает искомый пароль
        - completion: замыкание, в которое асинхронно передаются результаты поиска, вызывающий объект (ViewController) оперирует значениями
     */
    func crack(password searchPass: String, completion: QueueHandler) {
        var pass: String?
        let startTime = Date()
        let startString = "0000"
        let endString = "ZZZZ"
        
        let op1 = BruteForceOperation(startString: startString, endString: endString, password: searchPass)
        let op2 = BruteForceOperation(startString: startString, endString: endString, password: searchPass)
        let op3 = BruteForceOperation(startString: startString, endString: endString, password: searchPass)
        
        let opArray = [op1, op2, op3]
        
        addOperations(opArray, waitUntilFinished: false)
        
        opArray.forEach { operation in
            operation.completionBlock = { [weak self] in
                pass = operation.result
                self?.cancelAllOperations()
                if let p = pass, let handler = completion {
                    let time = "\(String(format: "Time: %.2f", Date().timeIntervalSince(startTime))) seconds"
                    handler(p, time)
                }
            }
        }
    }
}

