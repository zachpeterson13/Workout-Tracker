//
//  CalculatorSheetView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 4/3/23.
//

import SwiftUI

struct CalculatorSheetView: View {
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


struct CalculatorSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorSheetView(isShowing: .constant(true))
    }
}
