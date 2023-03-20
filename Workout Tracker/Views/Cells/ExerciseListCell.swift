//
//  ExerciseListCell.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/19/23.
//

import SwiftUI

struct ExerciseListCell: View {
    @Binding var exerciseSet: ExerciseSet
    @Binding var exercise: Exercise
    
    @State private var isShowingEditView = false
    
    var body: some View {
        HStack {
            Text("Reps: \(exerciseSet.reps)")
            
            Spacer()
            
            Text("Weight: \(exerciseSet.weight) lbs")
        }
        .onTapGesture {
            isShowingEditView = true
        }
        .sheet(isPresented: $isShowingEditView) {
            SetEditView(isShowing: $isShowingEditView,
                        exercise: $exercise,
                        set: $exerciseSet)
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
    }
}

struct ExerciseListCell_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListCell(exerciseSet: .constant(MockData.sampleExercise1.sets.first!), exercise: .constant(MockData.sampleExercise1))
    }
}
