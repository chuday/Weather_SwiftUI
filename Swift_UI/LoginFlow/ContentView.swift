//
//  ContentView.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 10.12.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var shouldShowCitiesView: Bool = false
    private let tokenSavedPublisher = NotificationCenter.default.publisher(for: NSNotification.Name("vkTokenSaved"), object: nil)
    
    var body: some View {
        NavigationView {
            HStack {
//                VKLoginWebView(isAuthorized: $shouldShowCitiesView)
                LoginView(showCitiesView: $shouldShowCitiesView)
                
                NavigationLink(destination: CitiesView(), isActive: $shouldShowCitiesView) {
                    EmptyView()
                }
            }
        }.onReceive(tokenSavedPublisher, perform: { _ in
            shouldShowCitiesView = true
        })
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
