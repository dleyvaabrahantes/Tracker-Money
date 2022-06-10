//
//  CategoryView.swift
//  Tracker Money
//
//  Created by David on 5/27/22.
//

import SwiftUI

struct CategoryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.self) var env
    @EnvironmentObject var operationViewMOdel: OperationViewModel
    
    @State var selectionCategore: String?
    @State var select = false
    
    var body: some View {
      
        VStack(spacing: 5){
            List(operationViewMOdel.categories, id: \.id, selection: $selectionCategore){item in
            HStack{
                Image(item.image)
                    .resizable()
                    .frame(width: 40, height: 40)
                    
                    
                Text(item.name)
                Spacer()
                Button {
                 //   operationViewMOdel.categories[getIndex(id: item.id.uuidString)].select.toggle()
                    operationViewMOdel.categoryStr = category(rawValue: operationViewMOdel.categories[getIndex(id: item.id.uuidString)].name) ?? .other
                    env.dismiss()
                } label: {
                    
                        
                }

            
        }

          //  .navigationBarItems(leading: EditButton())
        }
        
           .overlay(alignment: .topTrailing) {
            Button {
                env.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(Color("Black"))
                    .opacity(0.7)
                
            }
            .offset(y: -10)
            .padding()
        }
            
        }
    }
    
    func getIndex(id: String) ->Int {
        var index = 0
        for i in 0..<operationViewMOdel.categories.count {
            if id == operationViewMOdel.categories[i].id.uuidString {
                index = i
            }
        }
       return index
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
            .environmentObject(OperationViewModel())
    }
}
