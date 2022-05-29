//
//  CardOperationView.swift
//  Tracker Money
//
//  Created by David on 5/26/22.
//

import SwiftUI

struct CardOperationView: View {
    var operation: Operation
    @EnvironmentObject var viewModel : OperationViewModel
    var body: some View {
        HStack(spacing: 12){
            if let first = operation.name.first{
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background{
                        Circle()
                            .fill(Color("\(operation.color)"))
                        
                    }
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
            }
            VStack(spacing: 10){
            Text(operation.name)
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(operation.category.rawValue)
                    .font(.caption)
                    .fontWeight(.light)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
            }
            VStack(alignment: .trailing, spacing: 7) {
                let price = viewModel.convertNumberToString(value: operation.type == .input ? operation.total : -operation.total)
                Text(price)
                    .font(.callout)
                    .opacity(0.7)
                    .foregroundColor(operation.type == .input ? .green : .red)
                Text(operation.date.formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .opacity(0.5)
                    
                
            }
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
        }
    }
}

struct CardOperationView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
