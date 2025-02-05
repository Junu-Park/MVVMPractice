//
//  WordCounterViewModel.swift
//  MVVMPractice
//
//  Created by 박준우 on 2/5/25.
//

import Foundation

final class WordCounterObserver<T> {
    var value: T {
        didSet {
            self.closure?(value)
        }
    }
    
    var closure: ((T) -> ())?
    
    init(value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> ()) {
        closure(self.value)
        self.closure = closure
    }
}

final class WordCounterViewModel {
    
    private var defaultOutputData: String = "현재까지 0글자 작성중"
    
    var inputData: WordCounterObserver<String?> = WordCounterObserver(value: nil)
    
    lazy var outputData: WordCounterObserver<String> = WordCounterObserver(value: self.defaultOutputData)
    
    init() {
        self.inputData.closure = { text in
            self.countWords()
        }
    }
    
    private func countWords() {
        guard let inputString = self.inputData.value else {
            self.outputData.value = self.defaultOutputData
            return
        }
        self.outputData.value = "현재까지 \(inputString.count)글자 작성중"
    }
}
