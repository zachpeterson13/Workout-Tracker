//
//  DateChanger.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 4/3/23.
//

import SwiftUI

struct DateChanger: View {
    @ObservedObject var viewModel: DiaryListViewModel
    @ObservedObject var store: DayStore
    
    var body: some View {
        HStack {
            Button {
                viewModel.setDay(store: store)
                viewModel.date = viewModel.date.adding(days: -1)
            } label: {
                Image(systemName: "arrow.left")
            }
            .buttonStyle(.borderless)
            .tint(.gray)
            
            Button {
                viewModel.setDay(store: store)
                viewModel.swiftDate = viewModel.date.date
                viewModel.isShowingDatePicker = true
            } label: {
                Text("\(viewModel.date.date.formatted(date: .abbreviated, time: .omitted))")
                    .sheet(isPresented: $viewModel.isShowingDatePicker) {
                        DatePickerSheet(calendarDate: $viewModel.date, date: $viewModel.swiftDate, isShowing: $viewModel.isShowingDatePicker)
                            .presentationDetents([.medium])
                    }
            }
            .buttonStyle(.bordered)
            .tint(.gray)
            
            Button {
                viewModel.setDay(store: store)
                viewModel.date = viewModel.date.adding(days: 1)
            } label: {
                Image(systemName: "arrow.right")
            }
            .buttonStyle(.borderless)
            .tint(.gray)
        }
        .padding(8)
    }
}

struct DateChanger_Previews: PreviewProvider {
    static var previews: some View {
        DateChanger(viewModel: DiaryListViewModel(), store: DayStore())
    }
}
