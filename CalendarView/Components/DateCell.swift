//
//  DateCell.swift
//  TodoList
//
//  Created by HYEONJUN PARK on 2023/05/17.
//

import SwiftUI

struct DateCell : View {
    var text: String
    var color: Color = .white
    var lineColor: Color = .gray
    var alignment: Alignment = .center
    var body: some View {
        ZStack (alignment: alignment){
            Rectangle()
                .fill(color)
                .overlay(
                    Rectangle().stroke(lineColor, lineWidth: 0.5)
                )
            Text(text)
               // .font(.footnote)
                .frame(maxWidth: .infinity)
        }
    }
}
