//
//  FilterView.swift
//  Tracker Money
//
//  Created by David on 5/26/22.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var viewModel : OperationViewModel
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.self) var env
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15){
                HStack(spacing: 15){
                    Button{
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.gray)
                            
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }

                    
                        Text("Transaction")
                        .font(.title.bold())
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                   
                    Button{
                        viewModel.showFilter = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
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
                
                OperationCard(isFilter: true)
                    .environmentObject(viewModel)
                customSegment()
                    .padding(.top)
                
                VStack(spacing: 15){
                    Text(viewModel.convertDateToString())
                        .opacity(0.7)
                    
                    Text(viewModel.convertMoneyToString(operations: viewModel.operations, type: viewModel.tabName))
                        .font(.title.bold())
                        .opacity(0.9)
                        .animation(.none, value: viewModel.tabName)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
                .padding(.vertical, 20)
                
                ForEach(viewModel.operations.filter{
                    return $0.type == viewModel.tabName &&
                            $0.date >= viewModel.startDate &&
                            $0.date <= viewModel.endDate
                }){value in
                    CardOperationView(operation: value)
                        .environmentObject(viewModel)
                    
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .background{
            Color("BG")
                .ignoresSafeArea()
        }
        .overlay{
            filterView()
        }
        .onAppear {
            viewModel.endDate = Date()
        }
    }
    
    @ViewBuilder
    func customSegment()-> some View {
        HStack(spacing: 0){
            ForEach([typeOperation.out, typeOperation.input], id: \.rawValue){ tab in
                Text(tab.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(viewModel.tabName == tab ? .white : .black)
                    .opacity(viewModel.tabName == tab ? 1 : 0.7)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background{
                        if viewModel.tabName == tab {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                    LinearGradient(colors: [.blue, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.tabName = tab
                    }
            }
        }
        .padding(5)
        .background{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        }
    }
    
    @ViewBuilder
    func filterView()-> some View {
        ZStack{
            Color.black
                .opacity(viewModel.showFilter ? 0.25 : 0)
                .ignoresSafeArea()
            
            if viewModel.showFilter{
                VStack(alignment: .leading, spacing: 10){
                    Text("Start Date")
                        .font(.caption)
                        .opacity(0.7)
                    
                    DatePicker("", selection: $viewModel.startDate,in: Date.distantPast...Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                    
                    Text("End Date")
                        .font(.caption)
                        .opacity(0.7)
                        .padding(.top, 10)
                    
                    DatePicker("", selection: $viewModel.endDate,in: Date.distantPast...Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                    
                }
                .padding(20)
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                .overlay(alignment: .topTrailing, content: {
                    Button {
                        viewModel.showFilter = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.black)
                            .padding(5)
                    }

                })
                .padding()
            }
        }
        .animation(.easeInOut, value: viewModel.showFilter)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
            .environmentObject(OperationViewModel())
    }
}
