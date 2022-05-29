//
//  ContentView.swift
//  Tracker Money
//
//  Created by David on 5/26/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @AppStorage("currentPage") var currentPage = 1
    
    
    var body: some View {
        
        if currentPage > totalPage{
            NavigationView{
                Home()
                    .navigationBarHidden(true)
                    }
            }
        else {
            WalkthroughtScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
