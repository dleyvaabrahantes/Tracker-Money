//
//  Home.swift
//  Tracker Money
//
//  Created by David on 5/26/22.
//

import SwiftUI

struct Home: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var operationViewMOdel: OperationViewModel = .init()
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date, order: .reverse)
        
    ]) var items: FetchedResults<ExpensesMO>
    
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
        .fullScreenCover(isPresented: $operationViewMOdel.addNew){
            operationViewMOdel.clearData()
        } content: {
            NewExpense()
                .environmentObject(operationViewMOdel)
        }
        .overlay(alignment: .bottomTrailing){
            AddButton()
        }
        .onAppear {
            if operationViewMOdel.operations.isEmpty {
                PrintList()
            }
            
        }
    }
    
    @ViewBuilder
    func TransactionView()-> some View {
        VStack(spacing: 15){
            HStack(alignment: .top){
            Text("Transaction")
                .font(.title2.bold())
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            Image(systemName: "arrow.up.arrow.down")
                    .font(.title3.bold())
                    .opacity(0.7)
                    .padding(.horizontal)
            }
            ForEach(operationViewMOdel.operations){value in
                ZStack{
                    HStack{
                        Color.yellow
                            //.frame(maxWidth: .infinity)
                            .frame(width: 90)
                            .opacity(value.offset > 0 ? 1 : 0)
                            .cornerRadius(20)
                        Spacer()
                        Color.red
                            .frame(width: 90)
                            .opacity(value.offset < 0 ? 1 : 0)
                            .cornerRadius(20)
                        
                    }
                    .animation(.default)
                    HStack{
                        Button {
                            
                        } label: {
                            Image(systemName: "pin.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(width: 90)
                        
                        Spacer()
                        
                        Button {
                            operationViewMOdel.operations.remove(at: getIndex(id: value.id))
                            
                        } label: {
                            Image(systemName: "trash.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(width: 90)

                    }
                    CardOperationView(operation: value)
                        .environmentObject(operationViewMOdel)
                        .foregroundColor(.black)
                        .offset(x: value.offset)
                        .gesture(DragGesture().onChanged({ (valueDrag) in
                            operationViewMOdel.operations[getIndex(id: value.id)].offset = valueDrag.translation.width
                        })
                            .onEnded({ (valueDrag) in
                                if valueDrag.translation.width > 80 {
                                    operationViewMOdel.operations[getIndex(id: value.id)].offset = 90
                                } else if valueDrag.translation.width < -80 {
                                    operationViewMOdel.operations[getIndex(id: value.id)].offset = -90
                                    
                                } else {
                                    operationViewMOdel.operations[getIndex(id: value.id)].offset = 0
                                }
                            }))
                        .animation(.default)
                }
                
            }
           
//                    .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
//                        .onEnded { value in
//                            print(value.translation)
//                            switch(value.translation.width, value.translation.height) {
//                                case (...0, -30...30):  print("left swipe")
//                                case (0..., -30...30):  print("right swipe")
//                                case (-100...100, ...0):  print("up swipe")
//                                case (-100...100, 0...):  print("down swipe")
//                                default:  print("no clue")
//                            }
//                        }
                    
                
           
        }
        .padding(.top)
    }
    
    @ViewBuilder
    func AddButton()->some View{
        Button {
            operationViewMOdel.addNew.toggle()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background{
                    Circle()
                        .fill(
                            .linearGradient(colors: [.blue, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }
        .padding()
    }
    
    func PrintList(){
        for item in items {
            operationViewMOdel.operations.append(Operation(name: item.remark ?? "", total: item.total, date: item.date ?? Date(), type: typeOperation(rawValue: item.type ?? "All") ?? .all, color: item.color ?? "Black", category: category(rawValue: item.category ?? "Other") ?? .other))
        }
    }
    
    func getIndex(id: String) ->Int {
        var index = 0
        for i in 0..<operationViewMOdel.operations.count {
            if id == operationViewMOdel.operations[i].id {
                index = i
            }
        }
       return index
    }
    
        
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
