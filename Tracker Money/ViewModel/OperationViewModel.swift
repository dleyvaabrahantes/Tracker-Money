//
//  OperationViewModel.swift
//  Tracker Money
//
//  Created by David on 5/26/22.
//

import Foundation


class OperationViewModel: ObservableObject {
    @Published var operations: [Operation] = sample
    @Published var endDate: Date = Date()
    @Published var startDate: Date = Date()
    @Published var currentMontStart: Date = Date()
    
    @Published var tabName: typeOperation = .out
    
    init(){
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.year, .month], from: Date())
        
        startDate = calendar.date(from: comp)!
        currentMontStart = calendar.date(from: comp)!
    }
    
    func currentMonthString() -> String {
        return currentMontStart.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    func convertMoneyToString(operations : [Operation], type: typeOperation = .all) -> String {
        var value: Double = 0
        value = operations.reduce(0, { partialResult, operation in
            return partialResult + (type == .all ? (operation.type == .input ? operation.total : -operation.total) : (operation.type == type ? operation.total : 0))
        })
        
        return convertNumberToString(value: value)
    }
    
    func convertDateToString()-> String {
        return startDate.formatted(date: .abbreviated, time: .omitted) + " - " + endDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    func convertNumberToString(value: Double)-> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: .init(value: value)) ?? "$0.00"
        
    }
}
