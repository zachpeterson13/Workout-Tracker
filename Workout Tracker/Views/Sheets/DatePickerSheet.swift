//
//  DatePickerSheet.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 4/3/23.
//

import SwiftUI
import CalendarDate


struct DatePickerSheet: View {
    @Binding var calendarDate: CalendarDate
    @Binding var date: Date
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            DatePicker("Test", selection: $date, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .padding()
            
            Button {
                isShowing = false
            } label: {
                Label("Cancel", systemImage: "xmark")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(.red)
        }
        .onChange(of: date) { newValue in
            calendarDate = CalendarDate(date: date)
            isShowing = false
        }
    }
}

struct DatePickerSheet_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerSheet(calendarDate: .constant(CalendarDate.today),
                        date: .constant(Date()),
                        isShowing: .constant(true))
    }
}
