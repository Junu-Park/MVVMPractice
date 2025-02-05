//
//  UserViewModel.swift
//  MVVMPractice
//
//  Created by 박준우 on 2/5/25.
//

import Foundation

final class UserObserver<T> {
    var value: T {
        didSet {
            self.closure?(self.value)
        }
    }
    
    var closure: ((T) -> ())?
    
    init(value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> ()) {
        self.closure = closure
    }
}

final class UserViewModel {
    let loadInput: UserObserver<Void> = UserObserver(value: ())
    
    let resetInput: UserObserver<Void> = UserObserver(value: ())
    
    let addInput: UserObserver<Void> = UserObserver(value: ())
    
    let outputData: UserObserver<[Person]> = UserObserver(value: [])
    
    init() {
        self.loadInput.closure = { _ in
            self.loadDatas()
        }
        self.resetInput.closure = { _ in
            self.resetData()
        }
        self.addInput.closure = { _ in
            self.addData()
        }
    }
    
    private func loadDatas() {
        self.outputData.value = [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    private func resetData() {
        self.outputData.value.removeAll()
    }
    
    private func addData() {
        let names = ["James", "Mary", "John", "Patricia", "Robert", "Jennifer", "Michael", "Linda", "William", "Elizabeth", "David", "Barbara", "Richard", "Susan", "Joseph", "Jessica", "Thomas", "Sarah", "Charles", "Karen"]
        let user = Person(name: names.randomElement()!, age: Int.random(in: 20...70))
        self.outputData.value.append(user)
    }
}
