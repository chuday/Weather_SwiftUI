//
//  Swift_UIApp.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 05.12.2021.
//

import SwiftUI
import UIKit

@main
struct Swift_UIApp: App {
    
    let coreDataService = CoreDataService(modelName: "City")
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, coreDataService.context)
        }
    }
}
