//
//  DiaryDetailView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/18/23.
//

import SwiftUI

struct ExerciseEditView: View {
    @Binding var isShowingEditView: Bool
    @Binding var exercise: Exercise
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                XDismissButton()
                    .hidden()
                
                Spacer()
                
                Text("\(exercise.name)")
                
                Spacer()
                
                Button {
                    isShowingEditView = false
                } label: {
                    XDismissButton()
                }
            }
            .padding(.leading)
            .padding(.trailing)
            
            List() {
                ForEach (exercise.sets){ exerciseSet in
                    HStack {
                        Text("Reps: \(exerciseSet.reps)")
                        
                        Spacer()
                        
                        Text("Weight: \(exerciseSet.weight) lbs")
                    }
                    
                }
                .onDelete { indexSet in
                    exercise.sets.remove(atOffsets: indexSet)
                }
            }
            
            Button {
                exercise.name = "Test"
            } label: {
                Text("Test")
            }
            
            
            Spacer()
        }
    }
}

struct DiaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseEditView(isShowingEditView: .constant(false), exercise: .constant(MockData.sampleExercise1))
    }
}
