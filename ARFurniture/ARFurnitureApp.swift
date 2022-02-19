//
//  ARFurnitureApp.swift
//  ARFurniture
//
//  Created by KANISHK VIJAYWARGIYA on 18/01/22.
//

import SwiftUI

@main
struct ARFurnitureApp: App {
    @StateObject var placementSettings = PlacementSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}
