//
//  NewExpense.swift
//  Tracker Money
//
//  Created by David on 5/26/22.
//

import SwiftUI

struct NewExpense: View {
    @EnvironmentObject var viewModel : OperationViewModel
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.self) var env
    @State var showCategory = false
    @State var operation: Operation?
    var body: some View {
        VStack{
            VStack(spacing: 15){
                Text("Add Expense")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(0.5)
                
                if let symbol = viewModel.convertNumberToString(value: 0).first{
                    TextField("0", text: $viewModel.total)
                        .font(.system(size: 35))
                        .foregroundColor(.mint)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background{
                            Text(viewModel.total == "" ? "0" : viewModel.total)
                                .font(.system(size: 35))
                                .opacity(0)
                                .overlay(alignment: .leading){
                                    Text(String(symbol))
                                        .opacity(0.5)
                                        .offset(x: -15, y: 5)
                                }
                        }
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background{
                            Capsule()
                                .fill(.white)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top)
                }
                
                Label {
                    TextField("Remark", text: $viewModel.name)
                        .padding(.leading, 10)
                } icon: {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 25)
                
                Label {
                   checkBoxes()
                } icon: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 5)
                
                Label {
                    Button {
                        showCategory.toggle()
                    } label: {
                         Text("Seleccionar categoria")
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                } icon: {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 5)
                
                Label {
                    DatePicker.init("",selection: $viewModel.date, in: Date.distantPast ... Date(), displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                } icon: {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 5)
            }
            .frame(maxHeight: .infinity, alignment: .center)
            
            Button {
                viewModel.saveDate(env: env, context: managedObjectContext )
            } label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(LinearGradient(colors: [.blue, .green], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
            }
            .disabled(viewModel.name == "" || viewModel.type == .all || viewModel.total == "")
            .opacity(viewModel.name == "" || viewModel.type == .all || viewModel.total == "" ? 0.6 : 1)

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Color("BG")
                .ignoresSafeArea()
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
            .padding()
        }
        .sheet(isPresented: $showCategory) {
            CategoryView()
        }
    }
    
    @ViewBuilder
    func checkBoxes()->some View {
        HStack(spacing: 10){
            ForEach([typeOperation.input, typeOperation.out], id:\.self){type in
                ZStack{
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.black, lineWidth: 2)
                        .opacity(0.5)
                        .frame(width: 20, height: 20)
                    
                    if viewModel.type == type {
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor(.green)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.type = type
                }
                Text(type.rawValue.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .opacity(0.7)
                    .padding(.trailing, 10)
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 10)
    }
}

struct NewExpense_Previews: PreviewProvider {
    static var previews: some View {
        NewExpense()
            .environmentObject(OperationViewModel())
    }
}
