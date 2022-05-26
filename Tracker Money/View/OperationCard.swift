//
//  OperationCard.swift
//  Tracker Money
//
//  Created by David on 5/26/22.
//

import SwiftUI

struct OperationCard: View {
    @EnvironmentObject var operationViewMOdel: OperationViewModel
    var body: some View {
        GeometryReader{ proxy in
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    .linearGradient(colors: [.blue, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            VStack(spacing: 15){
                VStack(spacing: 15){
                    Text(operationViewMOdel.currentMonthString())
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text(operationViewMOdel.convertMoneyToString(operations: operationViewMOdel.operations))
                        .font(.system(size: 35, weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom,5)
                }
                .offset(y: -10)
                
                HStack(spacing: 15){
                    Image(systemName: "arrow.up")
                        .font(.caption.bold())
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7), in: Circle())
                    
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Expense")
                            .font(.caption)
                            .opacity(0.7)
                        Text(operationViewMOdel.convertMoneyToString(operations: operationViewMOdel.operations, type: .out))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "arrow.down")
                        .font(.caption.bold())
                        .foregroundColor(.green)
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7), in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Income")
                            .font(.caption)
                            .opacity(0.7)
                        Text(operationViewMOdel.convertMoneyToString(operations: operationViewMOdel.operations, type: .input))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                    
                    
                }
                .padding(.horizontal)
                .padding(.trailing)
                .offset(y: 15)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 220)
        .padding(.top)
    }
}
