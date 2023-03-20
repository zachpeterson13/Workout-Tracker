//
//  SetEditView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/19/23.
//

import SwiftUI

struct SetEditView: View {
    @Binding var isShowing: Bool
    @Binding var exercise: Exercise
    @Binding var set: ExerciseSet
    
    @StateObject var reps = NumbersOnly()
    @StateObject var weight = NumbersOnly()
    
    var body: some View {
        VStack {
            VStack {
                LabelTextField(title: "Repetitions", value: $reps.value)
                
                LabelTextField(title: "Weight(lbs)", value: $weight.value)
                
                VStack(spacing: 10) {
                    HStack() {
                        Button {
                            set.reps = Int(reps.value) ?? 0
                            set.weight = Int(weight.value) ?? 0
                            isShowing = false
                        } label: {
                            Label("Save Set", systemImage: "square.and.pencil")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        .tint(.green)
                        
                        
                        Button {
                            exercise.sets.removeAll(where: { $0.id == set.id })
                            isShowing = false
                        } label: {
                            Label("Delete Set", systemImage: "trash")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        .tint(.red)
                    }
                    
                    Button {
                        isShowing = false
                    } label: {
                        Label("Cancel", systemImage: "xmark.circle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .tint(.gray)
                }
                .padding()
            }
        }
        .onAppear {
            reps.value = String(set.reps)
            weight.value = String(set.weight)
        }
    }
}

struct SetEditView_Previews: PreviewProvider {
    static var previews: some View {
        SetEditView(isShowing: .constant(true),
                    exercise: .constant(MockData.sampleExercise1),
                    set: .constant(MockData.sampleExercise1.sets.first!))
    }
}

struct LabelTextField: View {
    let title: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            
            TextField(title, text: $value)
                .keyboardType(.numberPad)
                .padding(.all)
                .background(Color(.quaternarySystemFill))
                .cornerRadius(5)
        }
        .padding(.horizontal, 15)
    }
}
