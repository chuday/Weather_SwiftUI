//
//  CitiesView.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 10.12.2021.
//

import SwiftUI

struct CitiesView: View {
    
    @FetchRequest(
        entity: City.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \City.name, ascending: false)],
        predicate: nil,
        animation: .easeInOut
    )  var cities: FetchedResults<City>
    
    @State private var showingAddCityModal: Bool = false
    
    var body: some View {
        List(cities) { city in
            NavigationLink(destination: ForecastView(viewModel: ForecastViewModel(city: city, weatherService: WeatherService(), realmService: RealmService()))) {
                CityView(city: city)
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("Cities", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { self.showingAddCityModal.toggle() },
                                             label: { Image(systemName: "plus")}
                                            )
        )
        .sheet(isPresented: $showingAddCityModal) {
            AddCityView()
        }
    }
}

