//
//  CalendarView.swift
//  TodoList
//
//  Created by HYEONJUN PARK on 2023/05/16.
//

import SwiftUI

struct CalendarView: View {
    var cellSize: CGFloat = 50
    let allWeeks = ["일", "월", "화", "수", "목", "금", "토"]
    let dateFormatter = DateFormatter()
    @ObservedObject var viewModel = CalandarViewModel()
    var body: some View {
        VStack(spacing: 0) {
            header
            weeksHeader
            daysBody
        }
        .task {
            self.dateFormatter.dateFormat = "d"
            await viewModel.fetch(date: Date())
        }
    }
    
    var header: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .frame(width: cellSize * 7, height: cellSize/2)
                .cornerRadius(32, corners: [.topLeft, .topRight])
                .padding(.horizontal, 16)
            
            Text("\(viewModel.month)월")
                .foregroundColor(.gray)
        }
    }
    
    var weeksHeader: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(allWeeks, id: \.self) { weekday in
                    DateCell(text: weekday, color: Color("Orange"))
                        .frame(width: cellSize, height: cellSize / 2)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    var daysBody: some View {
        VStack(spacing: 0) {
            let dates = viewModel.dateInCurrentMonth
            let rows = (dates.count / 7) +
            (dates.count % 7 == 0 ? 0 : 1)
            ForEach(0..<rows, id: \.self) { row in
                HStack (spacing: 0) {
                    ForEach(0..<7) { column in
                        let index = row * 7 + column
                        if index >= dates.count || !isCurrentMonth(dates[index]) {
                            DateCell(text: "")
                                .frame(width: cellSize, height: cellSize)
                        }
                        else {
                            let day = dateFormatter.string(from: dates[index])
                            if isCurrentDay(dates[index]) {
                                DateCell(text: day, color: Color("Orange"), alignment: .bottom)
                                    .frame(width: cellSize, height: cellSize)
                                    .foregroundColor(.white)
                            } else {
                                DateCell(text: day, alignment: .bottom)
                                    .frame(width: cellSize, height: cellSize)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func isCurrentMonth(_ date: Date) -> Bool {
        return Calendar.current.isDate(.now, equalTo: date, toGranularity: .month)
    }
    private func isCurrentDay(_ date: Date) -> Bool {
        return Calendar.current.isDate(.now, equalTo: date, toGranularity: .day)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let cellSize = min((UIScreen.main.bounds.width - 32) / 7 , (500 - 32) / 7)
        CalendarView(cellSize: cellSize)
    }
}

struct CellShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Define your custom cell shape path here
        let cornerRadius: CGFloat = 0
        path.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        
        return path
    }
}
