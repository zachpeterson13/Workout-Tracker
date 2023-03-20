//
//  NumbersOnly.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/19/23.
//

import Foundation

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
        
    }
    
    init(value: String = "") {
        self.value = value
    }
}
