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
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .font(.title3)
                    .fontWeight(.bold)
                
                ForEach(exercise.sets) { set in
                    Text("\(set.reps) x \(set.weight) lbs")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color(.gray))
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(exercise.averageWeight)")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                
                Text("lbs")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.gray))
            }
        }
        .onTapGesture {
            isShowingEditView = true
        }
        .fullScreenCover(isPresented: $isShowingEditView) {
            ExerciseListView(isAdd: false, isShowing: $isShowingEditView, exercises: .constant([]), exercise: $exercise)
        }
    }
}

struct DiaryListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListViewCell(exercise: .constant(MockData.sampleExercise1))
    }
}
