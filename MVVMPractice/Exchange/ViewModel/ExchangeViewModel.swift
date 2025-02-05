//
//  ExchangeViewModel.swift
//  MVVMPractice
//
//  Created by 박준우 on 2/5/25.
//

import Foundation

final class ExchangeObserver<T> {
    var value: T {
        didSet {
            self.closure?(self.value)
        }
    }
    
    private var closure: ((T) -> Void)?
    
    init(value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        self.closure = closure
    }
}

final class ExchangeViewModel {
    private let exchangeRate: Double = 1446.0
    
    var currentRate: String {
        return "현재 환율: 1 USD = \(self.exchangeRate) KRW"
    }
    
    let inputData: ExchangeObserver<String?> = ExchangeObserver(value: nil)
    
    let outputData: ExchangeObserver<String> = ExchangeObserver(value: "")
    
    init() {
        inputData.bind { _ in
            self.exchangeToDollar()
        }
    }
    
    private func exchangeToDollar() {
        guard let won = Double(self.inputData.value ?? "") else {
            self.outputData.value = "올바른 금액을 입력해주세요"
            return
        }
        let dollar = won / self.exchangeRate
        
        self.outputData.value = String(format: "%.2f USD (약 $%.2f)", dollar, dollar)
    }
}
