//
//  ForecastViewModel.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 12.12.2021.
//

import SwiftUI
import RealmSwift

class ForecastViewModel: ObservableObject {
    let city: City
    let weatherService: WeatherService
    let realmService: AnyRealmService
    let objectWillChange = ObjectWillChangePublisher()
    
    private(set) lazy var weathers: Results<Weather>? = try? realmService.get(Weather.self, configuration: .deleteIfMigration).filter("id CONTAINS[cd] %@", city.name)
    var detachedWeathers: [Weather] { weathers?.map { $0.detached() } ?? [] }
    private var notificationToken: NotificationToken?
    
    init(city: City, weatherService: WeatherService, realmService: AnyRealmService) {
        self.city = city
        self.weatherService = weatherService
        self.realmService = realmService
        
        notificationToken = weathers?.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    public func fetchForecast() {
        print("Forecast requested")
        weatherService.forecast(for: city.name) { [weak self] result in
            switch result {
            case .success(let weathers):
                try? self?.realmService.save(items: weathers, configuration: .deleteIfMigration, update: .modified)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}
