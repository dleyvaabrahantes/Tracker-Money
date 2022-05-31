//
//  Expense.swift
//  Tracker Money
//
//  Created by David on 5/26/22.
//

import Foundation
import SwiftUI

struct Operation: Identifiable, Hashable {
    var id: String
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
    case oil = "Oil"
    case other = "Other"
    case defaul = "Select category"
}

struct categoryEntity {
    var id: UUID
    var name: String
    var image: String
    var select : Bool
}

var sample: [Operation] = [
    Operation(id: UUID().uuidString, name: "Keyboard", total: 99, date: Date(), type: .input, color: "Black", category: .food),
    Operation(id: UUID().uuidString, name: "Keyboard1", total: 100, date: Date(), type: .input, color: "Blue", category: .entertaiment),
    Operation(id: UUID().uuidString, name: "Keyb222oard", total: 99, date: Date(), type: .out, color: "Green", category: .shop),
    Operation(id: UUID().uuidString, name: "Keyb222oard", total: 99, date: Date(), type: .input, color: "Yellow", category: .food)

]

var sampleCategory:[categoryEntity] = [
    categoryEntity(id: UUID(), name: "Food", image: "food", select: false),
    categoryEntity(id: UUID(), name: "Shoping", image: "shopping", select: false),
    categoryEntity(id: UUID(), name: "Utilities", image: "tools", select: false),
    categoryEntity(id: UUID(), name: "Entertaiment", image: "entertaiment", select: false),
    categoryEntity(id: UUID(), name: "Oil", image: "oil", select: false),
    categoryEntity(id: UUID(), name: "Other", image: "other", select: false)
    

]
