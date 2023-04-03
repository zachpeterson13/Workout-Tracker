//
//  CalcViewCell.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 4/3/23.
//

import SwiftUI

struct CalcViewCell: View {
    @EnvironmentObject var store: DayStore
    let name: String
    
    var body: some View {
        HStack {
            Text("\(name)")
                .font(.title2)
                .fontWeight(.semibold)
            
            let calculatedMax = store.dict.values
                .flatMap { $0.exercises }
                .filter { $0.name == name }
                .flatMap { $0.sets }
                .reduce(0.0) { max($0, $1.oneRepMax) }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(calculatedMax, specifier: "%.2f")")
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

struct CalcViewCell_Previews: PreviewProvider {
    static let store = DayStore()
    
    static var previews: some View {
        CalcViewCell(name: "Test")
            .environmentObject(store)
    }
}
