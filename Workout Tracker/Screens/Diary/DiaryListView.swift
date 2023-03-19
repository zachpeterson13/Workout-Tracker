//
//  DiaryListView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/18/23.
//

import SwiftUI

struct DiaryListView: View {
    @State private var exercises: [Exercise] = MockData.exercises
    @State private var isShowingAddView = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.left")
                }
                
                Button {
                    
                } label: {
                    Text("\(Date().formatted(date: .abbreviated, time: .omitted))")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.right")
                }
            }
            
            List {
                ForEach($exercises) { $exercise in
                    DiaryListViewCell(exercise: $exercise)
                }
                .onDelete { indexSet in
                    exercises.remove(atOffsets: indexSet)
                }
            }
            
            Button {
                isShowingAddView = true
            } label: {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .padding()
            }
        }
        .fullScreenCover(isPresented: $isShowingAddView) {
            ExerciseAddView(isShowingAddView: $isShowingAddView, exercises: $exercises)
        }
    }
}

struct DiaryListView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListView()
    }
}


