//
//  Workout_TrackerApp.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/18/23.
//

import SwiftUI

@main
struct Workout_TrackerApp: App {
    var store = DayStore()
    
    var body: some Scene {
        WindowGroup {
            WorkoutTabView() {
                DayStore.save(dict: store.dict) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .environmentObject(store)
            .onAppear {
                DayStore.load { result in
                    switch result {
                    case .success(let dict):
                        print("FINISHED")
                        store.dict = dict
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    }
                }
            }
        }
    }
}
