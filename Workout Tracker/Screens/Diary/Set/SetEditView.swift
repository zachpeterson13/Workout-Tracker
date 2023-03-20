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
                
                HStack() {
                    Button {
                        set.reps = Int(reps.value) ?? 0
                        set.weight = Int(weight.value) ?? 0
                        isShowing = false
                    } label: {
                        Text("Save")
                    }
                    .padding()
                    
                    Button {
                        isShowing = false
                    } label: {
                        Text("Cancel")
                    }.padding()
                }
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
                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                .cornerRadius(5)
        }
        .padding(.horizontal, 15)
    }
}
