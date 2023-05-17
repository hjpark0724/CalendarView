//
//  CalendarViewModel.swift
//  TodoList
//
//  Created by HYEONJUN PARK on 2023/05/17.
//

import Foundation

@MainActor
class CalandarViewModel: ObservableObject {
    @Published var dateInCurrentMonth: [Date] = []
    @Published var month: String = ""
    var dateInPreviousMonth: [Date] = []
    var dateInNextMonth: [Date] = []
    
    func fetch(date: Date) async {
        var dates = await Task.detached(priority: .userInitiated) {
             return date.currentMonthOfDays
        }.value
        dateInCurrentMonth = dates
        month = Calendar.current.component(.month, from: dateInCurrentMonth.last!).formatted()
        dates = await Task.detached(priority: .userInitiated) {
            let next = Calendar.current.date(byAdding: .month, value: 1, to: date)!
            return next.currentMonthOfDays
        }.value
        dateInNextMonth = dates
        dates = await Task.detached(priority: .userInitiated) {
            let prev = Calendar.current.date(byAdding: .month, value: -1, to: date)!
            return prev.currentMonthOfDays
        }.value
        dateInPreviousMonth = dates
    }
    
    func fetchPrevious() async {
        let prev = Calendar.current.date(byAdding: .month, value: -1, to: dateInCurrentMonth[0])!
        if !dateInPreviousMonth.isEmpty {
            dateInNextMonth = dateInCurrentMonth
            dateInCurrentMonth = dateInPreviousMonth
            month = Calendar.current.component(.month, from: dateInCurrentMonth.last!).formatted()
            let dates = await Task.detached(priority: .userInitiated) {
                return prev.currentMonthOfDays
            }.value
            dateInPreviousMonth = dates
        } else {
            await fetch(date: prev)
        }
    }
    
    func fetchNext() async {
        let next = Calendar.current.date(byAdding: .month, value: 1, to: dateInCurrentMonth[0])!
        if !dateInNextMonth.isEmpty {
            dateInPreviousMonth = dateInCurrentMonth
            dateInCurrentMonth = dateInNextMonth
            month = Calendar.current.component(.month, from: dateInCurrentMonth.last!).formatted()
            let dates = await Task.detached(priority: .userInitiated) {
                return next.currentMonthOfDays
            }.value
            dateInNextMonth = dates
        } else {
            await fetch(date: next)
        }
    }
    
}
