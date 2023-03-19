//
//  DiaryListViewCell.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/19/23.
//

import SwiftUI

struct DiaryListViewCell: View {
    let exercise: Exercise
    
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
    }
}

struct DiaryListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListViewCell(exercise: MockData.sampleExercise1)
    }
}
