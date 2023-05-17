//
//  ContentView.swift
//  CalendarView
//
//  Created by HYEONJUN PARK on 2023/05/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            LinearGradient(
                colors: [Color("Background1"), Color("Background2")]
                , startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                CalendarView()
                Spacer()
            }.padding(.top, 64)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
