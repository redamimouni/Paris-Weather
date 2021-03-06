//
//  DailyForeCastService.swift
//  ParisWeather
//
//  Created by reda.mimouni on 14/07/2021.
//

import Foundation

protocol DailyForeCastServiceProtocol {
    func getDailyForeCast(completionHandler: @escaping (Result<Data, CustomError>) -> Void)
}

class DailyForeCastServiceImpl: DailyForeCastServiceProtocol {
    private let baseUrl: String

    private let appId: String
    private let city: String
    private let count: String
    lazy var request: URLRequest = {
        let url = URL(string: "\(baseUrl)data/2.5/forecast/daily?q=\(city)&mode=json&units=metric&cnt=\(count)&APPID=\(appId)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        return request
    }()
    
    init(baseUrl: String, apiKey: String, cityName: String, count: Int) {
        self.baseUrl = baseUrl
        self.appId = apiKey
        self.city = cityName
        self.count = String(count)
    }
    
    func getDailyForeCast(completionHandler: @escaping (Result<Data, CustomError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request, cachedResponseOnError: true) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.serviceError(localizedString: error.localizedDescription)))
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

enum CustomError: Error, Equatable {
    case serviceError(localizedString: String)
    case parsingError
    case dayNotFound
    case unknownError
}
