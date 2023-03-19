//
//  SetAddView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/18/23.
//

import SwiftUI


struct SetAddView: View {
    @Binding var isShowingAddSetView: Bool
    @Binding var exercise: Exercise
    
    @State private var set = ExerciseSet(id: UUID(), weight: 0, reps: 0)
    @StateObject private var reps = NumbersOnly()
    @StateObject private var weight = NumbersOnly()
    
    var body: some View {
        Form {
            TextField("Repititions", text: $reps.value)
                .keyboardType(.numberPad)
            
            TextField("Weight", text: $weight.value)
                .keyboardType(.numberPad)
            
            Button {
                set.reps = Int(reps.value) ?? 0
                set.weight = Int(weight.value) ?? 0
                exercise.sets.append(set)
                isShowingAddSetView = false
            } label: {
                Text("Add")
            }
        }
    }
}

struct SetAddView_Previews: PreviewProvider {
    static var previews: some View {
        SetAddView(isShowingAddSetView: .constant(true), exercise: .constant(MockData.sampleExercise1))
    }
}

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
        
    }
    
    init(value: String = "") {
        self.value = value
    }
}
