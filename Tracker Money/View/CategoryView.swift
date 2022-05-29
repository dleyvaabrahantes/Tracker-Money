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
    var categories = ["Food", "Entertaiment", "Other"]
    @State var selectionCategore: String?
    
    var body: some View {
        VStack(spacing: 5){
        List(categories, id: \.self, selection: $selectionCategore){item in
            HStack{
                Text(item)
                Spacer()
                Button {
                    print("select")
                } label: {
                    Circle()
                        .fill(.brown)
                        .frame(width: 20, height: 20)
                        
                }

            }
            
            
        }
        
           .overlay(alignment: .topTrailing) {
            Button {
                env.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.black)
                    .opacity(0.7)
                
            }
            .offset(y: -10)
            .padding()
        }
        
        }
    }
    
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
