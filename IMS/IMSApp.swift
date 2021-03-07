//
//  IMSApp.swift
//  IMS
//
//  Created by wov on 2021/2/12.
//

import SwiftUI

@main
struct IMSApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
