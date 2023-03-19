//
//  SetEditView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/19/23.
//

import SwiftUI

struct SetEditView: View {
    @Binding var isShowingEditSetView: Bool
    @Binding var set: ExerciseSet?
    
    @ObservedObject var reps: NumbersOnly
    @ObservedObject var weight: NumbersOnly
    
    var body: some View {
        Form {
            TextField("Repititions", text: $reps.value)
                .keyboardType(.numberPad)
            
            TextField("Weight", text: $weight.value)
                .keyboardType(.numberPad)
            
            Button {
                set?.reps = Int(reps.value) ?? 0
                set?.weight = Int(weight.value) ?? 0
                isShowingEditSetView = false
            } label: {
                Text("Add")
            }
        }
    }
}

struct SetEditView_Previews: PreviewProvider {
    static var previews: some View {
        SetEditView(isShowingEditSetView: .constant(true),
                    set: .constant(MockData.sampleExercise1.sets.first!),
                    reps: NumbersOnly(value: String(MockData.sampleExercise1.sets.first!.reps)),
                    weight: NumbersOnly(value: String(MockData.sampleExercise1.sets.first!.weight)))
    }
}
