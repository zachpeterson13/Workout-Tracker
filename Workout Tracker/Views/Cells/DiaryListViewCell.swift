//
//  DiaryListViewCell.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/19/23.
//

import SwiftUI

struct DiaryListViewCell: View {
    @Binding var exercise: Exercise
    
    @State private var isShowingEditView = false
    
    var body: some View {
        HStack {
            Image(systemName: "dumbbell")
            
            VStack(alignment: .leading) {
                Text(exercise.name)
                
                Text("\(exercise.sets.count) Sets")
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(exercise.sets.first?.weight ?? 0)")
                
                Text("lbs")
            }
        }
        .onTapGesture {
            isShowingEditView = true
        }
        .fullScreenCover(isPresented: $isShowingEditView) {
            ExerciseEditView(isShowingEditView: $isShowingEditView, exercise: $exercise)
        }
    }
}

struct DiaryListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListViewCell(exercise: .constant(MockData.sampleExercise1))
    }
}
