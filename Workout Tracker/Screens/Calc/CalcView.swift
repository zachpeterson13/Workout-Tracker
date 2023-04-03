//
//  HomeView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/18/23.
//

import SwiftUI

struct CalcView: View {
    @EnvironmentObject private var store: DayStore
    @State private var isShowingCalculator = false
    
    var body: some View {
        VStack {
            Text("Calculated One Rep Max")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            
            List {
                ForEach(Exercises.types, id: \.self) { name in
                    CalcViewCell(name: name)
                }
            }
            
            Button {
                isShowingCalculator = true
            } label: {
                Label("Open Calculator", systemImage: "equal")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(.gray)
            .padding()
        }
        .sheet(isPresented: $isShowingCalculator) {
            CalculatorSheetView(isShowing: $isShowingCalculator)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static let store = DayStore()
    
    static var previews: some View {
        CalcView()
            .environmentObject(store)
    }
}

