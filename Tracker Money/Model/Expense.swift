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
    var remark: String
    var total: Double
    var date: Date
    var type : typeOperation
    var color : Color
}

enum typeOperation: String {
    case input = "Income"
    case out = "Expense"
    case all = "All"
}

var sample: [Operation] = [
    Operation(remark: "Keyboard", total: 99, date: Date(), type: .input, color: .black),
    Operation(remark: "Keyboard1", total: 100, date: Date(), type: .input, color: .blue),
    Operation(remark: "Keyb222oard", total: 99, date: Date(), type: .out, color: .green),
    Operation(remark: "Keyb222oard", total: 99, date: Date(), type: .input, color: .yellow)

]
