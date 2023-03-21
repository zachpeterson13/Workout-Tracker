//
//  DiaryListView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/18/23.
//

import SwiftUI
import CalendarDate

struct DiaryListView: View {
    @State private var date: CalendarDate = CalendarDate.today
    @State private var day: Day = Day(id: CalendarDate.today, exercises: [])
    @State private var isShowingAddView = false
    
    func getData(date: CalendarDate) {
        DataManager.shared.getDay(date: date) { result in
            switch result {
            case .success(let day):
                self.day = day
            case.failure(let error):
                print(error)
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    DataManager.shared.setDay(date: date, day: day)
                    date = date.adding(days: -1)
                } label: {
                    Image(systemName: "arrow.left")
                }
                .buttonStyle(.borderless)
                .tint(.gray)
                
                Button {
                    DataManager.shared.setDay(date: date, day: day)
                } label: {
                    Text("\(date.date.formatted(date: .abbreviated, time: .omitted))")
                }
                .buttonStyle(.bordered)
                .tint(.gray)
                
                Button {
                    DataManager.shared.setDay(date: date, day: day)
                    date = date.adding(days: 1)
                } label: {
                    Image(systemName: "arrow.right")
                }
                .buttonStyle(.borderless)
                .tint(.gray)
            }
            .padding(8)
            
            List {
                ForEach($day.exercises) { $exercise in
                    DiaryListViewCell(exercise: $exercise, exercises: $day.exercises)
                }
                .onDelete { indexSet in
                    day.exercises.remove(atOffsets: indexSet)
                }
            }
            
            Button {
                day.exercises.append(Exercise(id: UUID(), name: "Unnamed Exercise", sets: []))
                isShowingAddView = true
            } label: {
                Label("Add Exercise", systemImage: "plus")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(.green)
        }
        .onChange(of: date, perform: { _ in
            getData(date: date)
        })
        .onAppear {
            getData(date: date)
        }
        .onDisappear{
            DataManager.shared.setDay(date: date, day: day)
        }
        .fullScreenCover(isPresented: $isShowingAddView) {
            ExerciseListView(isAdd: true, isShowing: $isShowingAddView, exercises: $day.exercises, exercise: $day.exercises.last!)
        }
    }
}

struct DiaryListView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListView()
    }
}


