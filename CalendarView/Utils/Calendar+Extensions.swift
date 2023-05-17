//
//  Calendar+Extensions.swift
//  TodoList
//
//  Created by HYEONJUN PARK on 2023/05/16.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)!
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }

    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
    
    var currentMonthOfDays: [Date] {
        var dates: [Date] = []
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        let start = calendar.date(from: components)!
        let weekday = Calendar.current.component(.weekday, from: start)
        let distance = weekday - 1
        for i in stride(from: distance, to: 0, by: -1) {
            let date = calendar.date(byAdding: .day, value: -1*(i), to: start)!
            dates.append(date)
        }
    
        dates.append(start)
        let end = calendar.date(byAdding: .month, value: 1, to: start)!
        calendar.enumerateDates(startingAfter: start,
                                matching: DateComponents(hour: 0, minute: 0),
                                matchingPolicy: .nextTime) { (date, _, stop) in
            guard let date = date else { return }
            if date < end {
                dates.append(date)
            } else {
                stop = true
            }
        }
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let formattedDates = dates.map { dateFormatter.string(from: $0) }
//        print(formattedDates)
        
        return dates
    }
}
