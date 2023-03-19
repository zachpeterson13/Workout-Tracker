//
//  DiaryAddView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/18/23.
//

import SwiftUI

struct ExerciseAddView: View {
    @Binding var exercises: [Exercise]
    @Binding var isShowingAddView: Bool
    
    let temp = ["Squat", "Bench Press", "Rows"]
    
    @State private var exercise = Exercise(id: UUID(), name: "", sets: [])
    @State private var isShowingAddSetView = false
    
    @State private var isShowingEditSetView = false
    @State private var selectedSet: ExerciseSet?
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                
                Spacer()
                
                Picker("Select Workout Type", selection: $exercise.name) {
                    ForEach(temp, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                
                Spacer()
                
                Button {
                    isShowingAddView = false
                } label: {
                    XDismissButton()
                        .padding()
                }
            }
            
            List {
                ForEach (exercise.sets){ exerciseSet in
                    HStack {
                        Text("Reps: \(exerciseSet.reps)")
                        
                        Spacer()
                        
                        Text("Weight: \(exerciseSet.weight) lbs")
                    }
                    .onTapGesture {
                        selectedSet = exerciseSet
                        isShowingEditSetView = true
                    }
                }
                .onDelete { indexSet in
                    exercise.sets.remove(atOffsets: indexSet)
                }
            }
            
            HStack {
                Spacer()
                
                Button {
                    isShowingAddSetView = true
                } label: {
                    Text("New set")
                }
                
                Spacer()
                
                Button {
                    exercises.append(exercise.self)
                    isShowingAddView = false
                } label: {
                    Text("Add")
                }
                
                Spacer()
            }
            
            
            Spacer()
        }
        .sheet(isPresented: $isShowingAddSetView) {
            SetAddView(isShowingAddSetView: $isShowingAddSetView, exercise: $exercise)
                .presentationDetents([.fraction(0.3), .medium])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $isShowingEditSetView) {
            SetEditView(isShowingEditSetView: $isShowingEditSetView,
                        set: $selectedSet,
                        reps: NumbersOnly(value: String(selectedSet?.reps ?? 0)),
                        weight: NumbersOnly(value: String(selectedSet?.weight ?? 0)))
        }
        
    }
}

struct DiaryAddView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseAddView(exercises: .constant(MockData.exercises), isShowingAddView: .constant(true))
    }
}



