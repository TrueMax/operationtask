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
        var pass: String = ""
        let startTime = Date()
        var operationArray: Array<BruteForceOperation> = []
        
        for character in searchPass {
            let op = BruteForceOperation(passwordChar: character)
            operationArray.append(op)
        }
        
        addOperations(operationArray, waitUntilFinished: true)
        
        operationArray.forEach { operation in
            guard let r = operation.result else { print("wrong symbol")
            return }
            pass += r
        }
        if let handler = completion {
            let time = "\(String(format: "Time: %.2f", Date().timeIntervalSince(startTime))) seconds"
            handler(pass, time)
        }
    }
}

