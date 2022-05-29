//
//  OperationViewModel.swift
//  Tracker Money
//
//  Created by David on 5/26/22.
//

import Foundation
import SwiftUI
import CoreData


class OperationViewModel: ObservableObject {
    @Published var operations: [Operation] = []
    @Published var endDate: Date = Date()
    @Published var startDate: Date = Date()
    @Published var currentMontStart: Date = Date()
    
    @Published var tabName: typeOperation = .out
    
    @Published var showFilter: Bool = false
    
    @Published var addNew: Bool = false
    @Published var total: String = ""
    @Published var type: typeOperation = .all
    @Published var date:Date = Date()
    @Published var name: String = ""
    @Published var categoryStr: category = .other
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date, order: .reverse)
        
    ]) var items: FetchedResults<ExpensesMO>
    
    var colors = ["Yellow", "Blue", "Red", "Green"]
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
            //return partialResult + (type == .all ? (operation.type == .input ? operation.total : -operation.total) : (operation.type == type && operation.date >= startDate && operation.date <= endDate ? operation.total : 0))
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
    
    func clearData(){
        date = Date()
        type = .all
        name = ""
        total = ""
    }
    
    func saveDate(env: EnvironmentValues, context: NSManagedObjectContext){
        print("save")
        print(date)
        let amountDouble = (total as NSString).doubleValue
       let color = colors.randomElement() ?? "Black"
        let object = Operation(name: name, total: amountDouble, date: date, type: type, color: color , category: categoryStr)
        withAnimation {
            operations.append(object)
        }
        operations = operations.sorted(by: {first, scnd in
            return scnd.date < first.date
        })
        
        let item = ExpensesMO(context: context)
        item.id = UUID()
        item.remark = name
        item.total = amountDouble
        item.date = date
        item.type = type.rawValue
        item.color = color
        item.category = categoryStr.rawValue
        
        PersistenceController.shared.save()
        
        env.dismiss()
        
    }
}
