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
    
    @StateObject var viewModel = DiaryListViewModel()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        VStack {
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
                            TestPicker(calendarDate: $viewModel.date, date: $viewModel.swiftDate, isShowing: $viewModel.isShowingDatePicker)
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
            
            List {
                ForEach($viewModel.day.exercises) { $exercise in
                    DiaryListViewCell(exercise: $exercise, exercises: $viewModel.day.exercises)
                }
                .onDelete { indexSet in
                    viewModel.day.exercises.remove(atOffsets: indexSet)
                }
            }
            
            Button {
                viewModel.day.exercises.append(Exercise(id: UUID(), name: "Unnamed Exercise", sets: []))
                viewModel.isShowingAddView = true
            } label: {
                Label("Add Exercise", systemImage: "plus")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(.green)
        }
        .onChange(of: viewModel.date) { _ in
            viewModel.getDay(store: store)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { viewModel.setDay(store: store) }
        }
        .onAppear {
            viewModel.getDay(store: store)
        }
//        .onDisappear{
//            setDay()
//        }
        .fullScreenCover(isPresented: $viewModel.isShowingAddView) {
            ExerciseListView(isAdd: true, isShowing: $viewModel.isShowingAddView, exercises: $viewModel.day.exercises, exercise: $viewModel.day.exercises.last!)
        }
    }
}

struct DiaryListView_Previews: PreviewProvider {
    static let store = DayStore()
    
    static var previews: some View {
        DiaryListView()
            .environmentObject(store)
    }
}


struct TestPicker: View {
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
