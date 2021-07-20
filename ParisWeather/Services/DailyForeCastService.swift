//
//  DailyForeCastService.swift
//  ParisWeather
//
//  Created by reda.mimouni on 14/07/2021.
//

import Foundation

protocol DailyForeCastServiceProtocol {
    func getDailyForeCast(completionHandler: @escaping (Result<Data, Error>) -> Void)
}

class DailyForeCastServiceImpl: DailyForeCastServiceProtocol {
    private let appId: String
    private let city: String
    private let count: String
    lazy var request: URLRequest = {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily?q=\(city)&mode=json&units=metric&cnt=\(count)&APPID=\(appId)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        return request
    }()
    
    init(apiKey: String, cityName: String, count: Int) {
        self.appId = apiKey
        self.city = cityName
        self.count = String(count)
    }
    
    func getDailyForeCast(completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            if let response = response as? HTTPURLResponse {
                print("HTTP Status code: \(response.statusCode)")
            }
            if let data = data {
                completionHandler(.success(data))
            }
        }
        task.resume()
    }
}
