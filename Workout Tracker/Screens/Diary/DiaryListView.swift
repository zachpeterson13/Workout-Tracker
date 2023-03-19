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
    @State private var isShowingEditView = false
    @State private var selectedIndex = 0
    
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
                ForEach(0..<exercises.count, id: \.self) { index in
                    DiaryListViewCell(exercise: exercises[index])
                        .onTapGesture {
                            selectedIndex = index
                            isShowingEditView = true
                        }
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
            ExerciseAddView(exercises: $exercises, isShowingAddView: $isShowingAddView)
        }
        .fullScreenCover(isPresented: $isShowingEditView) {
            ExerciseEditView(exercise: $exercises[selectedIndex], isShowingEditView: $isShowingEditView)
        }
    }
}

struct DiaryListView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListView()
    }
}


