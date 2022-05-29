//
//  Expense.swift
//  Tracker Money
//
//  Created by David on 5/26/22.
//

import Foundation
import SwiftUI

struct Operation: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
    var total: Double
    var date: Date
    var type : typeOperation
    var color : String
    var category : category
    var offset: CGFloat = 0
}

enum typeOperation: String {
    case input = "Income"
    case out = "Expense"
    case all = "All"
}

enum category: String {
    case food = "Food"
    case shop = "Shoping"
    case utily = "Utilities"
    case entertaiment = "Entertaiment"
    case other = "Other"
}

var sample: [Operation] = [
    Operation(name: "Keyboard", total: 99, date: Date(), type: .input, color: "Black", category: .food),
    Operation(name: "Keyboard1", total: 100, date: Date(), type: .input, color: "Blue", category: .entertaiment),
    Operation(name: "Keyb222oard", total: 99, date: Date(), type: .out, color: "Green", category: .shop),
    Operation(name: "Keyb222oard", total: 99, date: Date(), type: .input, color: "Yellow", category: .food)

]
