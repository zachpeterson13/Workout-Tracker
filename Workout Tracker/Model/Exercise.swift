//
//  Exercise.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/18/23.
//

import Foundation
import CalendarDate

struct Day: Codable, Identifiable {
    let id: CalendarDate
    var exercises: [Exercise]
}

struct Exercise: Codable, Identifiable {
    let id: UUID
    var name: String
    var sets: [ExerciseSet]
    
    var averageWeight: Int {
        let total = sets.reduce(0) { partialResult, set in
            partialResult + set.weight * set.reps
        }
        
        let numSets = sets.reduce(0) { partialResult, set in
            partialResult + set.reps
        }
        
        if numSets == 0 {
            return 0
        } else{
            return Int(total / numSets)
        }
    }
}

struct ExerciseSet: Codable, Identifiable {
    let id: UUID
    var weight: Int
    var reps: Int
}

struct MockData {
    static let sampleExercise1 = Exercise(id: UUID(), name: "Bench Press", sets: [ExerciseSet(id: UUID(), weight: 135, reps: 8),
                                                         ExerciseSet(id: UUID(), weight: 135, reps: 8),
                                                         ExerciseSet(id: UUID(), weight: 135, reps: 8)])
    
    static let sampleExercise2 = Exercise(id: UUID(), name: "Squat", sets: [ExerciseSet(id: UUID(), weight: 135, reps: 8),
                                                         ExerciseSet(id: UUID(), weight: 135, reps: 8),
                                                         ExerciseSet(id: UUID(), weight: 135, reps: 8)])
    
    static let sampleExercise3 = Exercise(id: UUID(), name: "Rows", sets: [ExerciseSet(id: UUID(), weight: 135, reps: 8),
                                                         ExerciseSet(id: UUID(), weight: 135, reps: 8),
                                                         ExerciseSet(id: UUID(), weight: 135, reps: 8)])
    
    static let sampleExercise4 = Exercise(id: UUID(), name: "Shoulder Press", sets: [ExerciseSet(id: UUID(), weight: 135, reps: 8),
                                                         ExerciseSet(id: UUID(), weight: 135, reps: 8),
                                                         ExerciseSet(id: UUID(), weight: 135, reps: 8)])
    
    
    static let exercises = [sampleExercise1, sampleExercise2, sampleExercise3, sampleExercise4]
    
    static let sampleDay = Day(id: CalendarDate.today, exercises: exercises)
}
