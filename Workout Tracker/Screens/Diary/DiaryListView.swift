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
            DateChanger(viewModel: viewModel, store: store)
            
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
            .padding()
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
        .onDisappear {
            viewModel.setDay(store: store)
        }
        .fullScreenCover(isPresented: $viewModel.isShowingAddView) {
            ExerciseListView(isShowing: $viewModel.isShowingAddView, exercises: $viewModel.day.exercises, exercise: $viewModel.day.exercises.last!)
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
