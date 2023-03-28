//
//  DayStore.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/27/23.
//

import Foundation
import SwiftUI
import CalendarDate

final class DayStore: ObservableObject {
    @Published var dict: [CalendarDate:Day] = [:]
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("days.data")
    }
    
    static func load(completion: @escaping (Result<[CalendarDate:Day], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([:]))
                    }
                    return
                }
                let dict = try JSONDecoder().decode([CalendarDate:Day].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(dict))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(dict: [CalendarDate:Day], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(dict)
                let outfile = try fileURL()
                try data.write(to: outfile)
                
                DispatchQueue.main.async {
                    completion(.success(dict.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
