//
//  Home.swift
//  Tracker Money
//
//  Created by David on 5/26/22.
//

import SwiftUI

struct Home: View {
    @StateObject var operationViewMOdel: OperationViewModel = .init()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12){
                HStack(spacing: 15){
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome!")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Text("David")
                            .font(.title2.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    NavigationLink {
                        FilterView()
                            .environmentObject(operationViewMOdel)
                    } label: {
                        Image(systemName: "hexagon.fill")
                            .foregroundColor(.gray)
                            .overlay(content: {
                                Circle()
                                    .stroke(.white, lineWidth: 2)
                                    .padding(7)
                            })
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                        
                    }


                }
                OperationCard()
                    .environmentObject(operationViewMOdel)
                TransactionView()
            }
            .padding()
        }
        .background{
            Color("BG")
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func TransactionView()-> some View {
        VStack(spacing: 15){
            Text("Transaction")
                .font(.title2.bold())
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            
            ForEach(operationViewMOdel.operations){value in
                CardOperationView(operation: value)
                    .environmentObject(operationViewMOdel)
                
            }
        }
        .padding(.top)
    }
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
