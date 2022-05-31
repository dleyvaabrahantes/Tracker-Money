//
//  WalkPage.swift
//  Tracker Money
//
//  Created by David on 5/27/22.
//

import SwiftUI

struct WalkPage: View {
    @AppStorage("currentWeight") var currentWeight: Double = 50
    @AppStorage("currentPage") var currentPage = 1

    
    
    var image: String
    var title: String
    var detail: String
    var color: Color
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                
                if currentPage == 1 {
                    Text("Hello!!!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                } else {
                    Button {
                        withAnimation(.easeInOut){
                            currentPage -= 1
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    }
                    
                }
                Spacer()
                
                Button {
                    withAnimation(.easeInOut){
                        currentPage = 4
                    }
                } label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                }
                
            }
            .foregroundColor(.black)
            .padding()
            Spacer(minLength: 0)
            if currentPage == 1 {
                Image(image)
                    .resizable()
                    .frame(height: 400)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                Text("Track your money")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top, 20)
            }
            if currentPage == 2 {
                Image(image)
                    .resizable()
                    .frame(height: 380)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                Text("Check total money at all times")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top, 20)
            }
            if currentPage == 3 {
                Image(image)
                    .resizable()
                    .frame(height: 280)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                Text("Organize your type of expenses")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top, 20)
            }
            //            else {
            //                Text(title)
            //                    .font(.title)
            //                    .fontWeight(.bold)
            //                    .foregroundColor(.black)
            //                    .padding(.top)
            //                Text(detail)
            //                    .fontWeight(.semibold)
            //                    .kerning(1.3)
            //                    .multilineTextAlignment(.center)
            //            }
            
            
            Spacer(minLength: 120)
        }
        .background(color.cornerRadius(10).ignoresSafeArea())
    }
}
