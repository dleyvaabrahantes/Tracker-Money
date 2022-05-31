//
//  WalkthroughtScreen.swift
//  Tracker Money
//
//  Created by David on 5/27/22.
//

import SwiftUI

struct WalkthroughtScreen : View {
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        
        ZStack {
            
            if currentPage == 1 {
                WalkPage(image: "money", title: "Importancia", detail: "Importancia sadaadadasd", color: Color("Blue"))
                    .transition(.scale)
            }
            
            if currentPage == 2 {
            //    TimeSleep()
                WalkPage(image: "check", title: "Importancia", detail: "Importancia sadaadadasd", color: Color("Yellow"))
                    .transition(.scale)
            }
            
            if currentPage == 3 {
                WalkPage(image: "flat", title: "Importancia", detail: "Importancia sadaadadasd", color: Color("White"))
                    .transition(.scale)
            }
        }
        .overlay(
            Button(action: {
                withAnimation(.easeInOut){
                    if currentPage <= totalPage {
                        currentPage += 1
                    }
                    else {
                        currentPage = 1
                    }
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                
                    .overlay(
                        ZStack{
                            Circle()
                                .stroke(Color.black.opacity(0.04), lineWidth: 4)
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPage))
                                .stroke(Color.white, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                            .padding(-15)
                    )
                
            })
            .padding(.bottom, 20)
            ,alignment: .bottom
        )
    }
}

var totalPage = 3
