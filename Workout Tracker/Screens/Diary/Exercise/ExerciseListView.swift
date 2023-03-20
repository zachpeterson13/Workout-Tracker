//
//  ExerciseListView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/19/23.
//

import SwiftUI

struct ExerciseListView: View {
    let isAdd: Bool
    @Binding var isShowing: Bool
    @Binding var exercises: [Exercise]
    @Binding var exercise: Exercise
    
    let temp = ["Squat", "Bench Press", "Rows", "Shoulder Press", "Unnamed Exercise"]
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Picker("Select Workout Type", selection: $exercise.name) {
                    ForEach(temp, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.menu)
                .buttonStyle(.bordered)
                .tint(.gray)
            }
            
            List {
                ForEach ($exercise.sets){ $exerciseSet in
                    ExerciseListCell(exerciseSet: $exerciseSet, exercise: $exercise)
                }
                .onDelete { indexSet in
                    exercise.sets.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.insetGrouped)
            
            VStack {
                Button {
                    exercise.sets.append(ExerciseSet(id: UUID(), weight: 0, reps: 0))
                } label: {
                    Label("Add Set", systemImage: "plus")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .tint(.gray)
                
                HStack {
                    
                    Button {
                        isShowing = false
                    } label: {
                        Label("Save Exercise", systemImage: "square.and.pencil")
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .tint(.green)
                    
                    
                    Button {
                        exercises.removeAll { $0.id == exercise.id }
                        isShowing = false
                    } label: {
                        Label("Delete Exercise", systemImage: "trash")
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .tint(.red)
                }
            }
            
            
            Spacer()
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView(isAdd: true, isShowing: .constant(true),
                         exercises: .constant(MockData.exercises),
                         exercise: .constant(MockData.exercises.first!))
    }
}
