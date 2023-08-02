//
//  DemoApp.swift
//  Demo
//
//  Created by LL on 2023/8/2.
//

import SwiftUI

@main
struct DemoApp: App {
    
    @StateObject var progressState = ProgressState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .ProgressHUD(isPresented: $progressState.isPresented)
                .environmentObject(progressState)
        }
    }
}
