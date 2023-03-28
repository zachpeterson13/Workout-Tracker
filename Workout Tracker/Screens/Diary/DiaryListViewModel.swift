//
//  DiaryListViewModel.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/27/23.
//

import SwiftUI
import CalendarDate

final class DiaryListViewModel: ObservableObject {
    @Published var date: CalendarDate = CalendarDate.today
    @Published var swiftDate = Date()
    @Published var day: Day = Day(id: CalendarDate.today, exercises: [])
    
    @Published var isShowingAddView = false
    @Published var isShowingDatePicker = false
    
    func getDay(store: DayStore) {
        guard let day = store.dict[date] else {
            store.dict[date] = Day(id: date, exercises: [])
            return getDay(store: store)
        }
        
        self.day = day
    }
    
    func setDay(store: DayStore) {
        store.dict[date] = day
    }
}
