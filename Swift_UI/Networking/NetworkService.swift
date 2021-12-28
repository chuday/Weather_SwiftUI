//
//  NetworkService.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 12.12.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol AnyWeatherService {
    func forecast(for city: String, completion: ((Swift.Result<[Weather], Error>) -> Void)?)
}

class WeatherService: AnyWeatherService {
    static let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        let session = Session(configuration: config)
        return session
    }()
    
    private let scheme = "https://"
    private let host = "api.openweathermap.org"
    private let appId = "8b32f5f2dc7dbd5254ac73d984baf306"
    
    func forecast(for city: String, completion: ((Swift.Result<[Weather], Error>) -> Void)? = nil) {
        let path = "/data/2.5/forecast"
        let params = [
            "q": city,
            "units": "metric",
            "appId": appId
        ]
        
        WeatherService.session.request(scheme + host + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case let .success(data):
                let json = JSON(data)
                
                if let errorMessage = json["message"].string {
                    let error = BackendError.cityNotFound(message: errorMessage)
                    completion?(.failure(error))
                    return
                }
                
                let weatherJSONs = json["list"].arrayValue
                let weathers = weatherJSONs.map { Weather(from: $0, city: city) }
                completion?(.success(weathers))
                
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }
}
