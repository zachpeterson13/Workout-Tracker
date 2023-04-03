//
//  LabelTextField.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 4/3/23.
//

import SwiftUI

struct LabelTextField: View {
    let title: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            
            TextField(title, text: $value)
                .keyboardType(.numberPad)
                .padding(.all)
                .background(Color(.quaternarySystemFill))
                .cornerRadius(5)
        }
        .padding(.horizontal, 15)
    }
}

struct LabelTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabelTextField(title: "Test", value: .constant("String"))
    }
}
