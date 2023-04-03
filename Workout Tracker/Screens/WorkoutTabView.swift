//
//  ContentView.swift
//  Workout Tracker
//
//  Created by Zach Peterson on 3/18/23.
//

import SwiftUI
import CalendarDate

struct WorkoutTabView: View {
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    var body: some View {
        TabView {
            CalcView()
                .tabItem {
                    Image(systemName: "plusminus.circle")
                    Text("Calculator")
                }
            
            DiaryListView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Diary")
                }
            
//            SettingsView()
//                .tabItem {
//                    Image(systemName: "gear")
//                    Text("Settings")
//                }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let store = DayStore()
    
    static var previews: some View {
        WorkoutTabView(saveAction: {})
            .environmentObject(store)
    }
}
