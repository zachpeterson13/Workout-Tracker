//
//  DiaryListView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/18/23.
//

import SwiftUI
import CalendarDate

struct DiaryListView: View {
    @EnvironmentObject var store: DayStore
    
    @State private var date: CalendarDate = CalendarDate.today
    @State private var day: Day = Day(id: CalendarDate.today, exercises: [])
    @State private var isShowingAddView = false
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    setDay()
                    date = date.adding(days: -1)
                } label: {
                    Image(systemName: "arrow.left")
                }
                .buttonStyle(.borderless)
                .tint(.gray)
                
                Button {
                    setDay()
                } label: {
                    Text("\(date.date.formatted(date: .abbreviated, time: .omitted))")
                }
                .buttonStyle(.bordered)
                .tint(.gray)
                
                Button {
                    setDay()
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
        .onChange(of: date) { _ in
            getDay()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { setDay() }
        }
        .onAppear {
            getDay()
        }
        .onDisappear{
            setDay()
        }
        .fullScreenCover(isPresented: $isShowingAddView) {
            ExerciseListView(isAdd: true, isShowing: $isShowingAddView, exercises: $day.exercises, exercise: $day.exercises.last!)
        }
    }
    
    func getDay() {
        guard let day = store.dict[date] else {
            store.dict[date] = Day(id: date, exercises: [])
            return getDay()
        }
        
        self.day = day
    }
    
    func setDay() {
        store.dict[date] = day
    }
    
}

struct DiaryListView_Previews: PreviewProvider {
    static let store = DayStore()
    
    static var previews: some View {
        DiaryListView()
            .environmentObject(store)
    }
}


