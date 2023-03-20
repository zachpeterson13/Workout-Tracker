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
                    if isAdd {
                        exercises.removeAll { $0.id == exercise.id }
                    }
                    isShowing = false
                } label: {
                    XDismissButton()
                        .padding()
                }
            }
            
            List {
                ForEach ($exercise.sets){ $exerciseSet in
                    ExerciseListCell(exerciseSet: $exerciseSet)
                }
                .onDelete { indexSet in
                    exercise.sets.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.insetGrouped)
            
            HStack {
                Spacer()
                
                Button {
                    exercise.sets.append(ExerciseSet(id: UUID(), weight: 0, reps: 0))
                } label: {
                    Text("New set")
                }
                
                Spacer()
                
                Button {
                    isShowing = false
                } label: {
                    if isAdd {
                        Text("Add")
                    } else {
                        Text("Save")
                    }
                }
                Spacer()
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
        
        ExerciseListView(isAdd: false, isShowing: .constant(true),
                         exercises: .constant(MockData.exercises),
                         exercise: .constant(MockData.exercises.first!))
    }
}
