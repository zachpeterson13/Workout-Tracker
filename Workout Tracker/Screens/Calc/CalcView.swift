//
//  HomeView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/18/23.
//

import SwiftUI

struct CalcView: View {
    @EnvironmentObject var store: DayStore
    @State private var isShowingCalculator = false
    
    let temp = ["Squat", "Bench Press", "Rows", "Shoulder Press"]
    
    var body: some View {
        VStack {
            Text("Calculated One Rep Max")
                .font(.title2)
                .fontWeight(.bold)
            
            List {
                ForEach(temp, id: \.self) { name in
                    HStack {
                        Text("\(name)")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        let test = store.dict.values
                            .flatMap { $0.exercises }
                            .filter { $0.name == name }
                            .flatMap { $0.sets }
                            .reduce(0.0) { max($0, $1.oneRepMax) }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("\(test, specifier: "%.2f")")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("lbs")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                        }
                    }
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
            Temp(isShowing: $isShowingCalculator)
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

struct Temp: View {
    @Binding var isShowing: Bool
    
    @StateObject private var reps = NumbersOnly()
    @StateObject private var weight = NumbersOnly()
    @State private var max = 0.0
    
    var body: some View {
        VStack(spacing: 15) {
            Text("One Rep Max Calculator")
                .font(.title)
                .fontWeight(.semibold)
            
            LabelTextField(title: "Weight (lbs)", value: $weight.value)
            
            LabelTextField(title: "Repititions", value: $reps.value)
            
            Text("1RM = \(max, specifier: "%.2f") Lbs")
                .font(.title3)
                .fontWeight(.semibold)
            
            HStack {
                Button {
                    max = ((Double(weight.value) ?? 0.0) / (1.0278 - (0.0278 * (Double(reps.value) ?? 0.0))))
                } label: {
                    Label("Calculate", systemImage: "equal.circle")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .tint(.green)
                
                Button {
                    isShowing = false
                } label: {
                    Label("Close", systemImage: "xmark")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .tint(.red)
            }
            .padding([.leading, .trailing], 10)
        }
    }
}
