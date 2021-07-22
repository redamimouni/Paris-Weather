//
//  ForecastDetailRepository.swift
//  ParisWeather
//
//  Created by reda.mimouni on 22/07/2021.
//

import Foundation

protocol ForecastDetailRepositoryProtocol {
    func getForecastFor(day timeStamp: Int, completionHandler: @escaping (Result<DailyForeCastEntity, CustomError>) -> Void)
}

class ForecastDetailRepositoryImpl: ForecastDetailRepositoryProtocol {
    func getForecastFor(day timeStamp: Int, completionHandler: @escaping (Result<DailyForeCastEntity, CustomError>) -> Void) {
        completionHandler(.success(DailyForeCastEntity.mock))
    }
}

extension DailyForeCastEntity {
    static let mock = DailyForeCastEntity(city: City(id: 2988507,
                                                     name: "Paris",
                                                     coord: Coord(lon: 2.3488, lat: 48.8534),
                                                     country: "FR",
                                                     population: 2138551,
                                                     timezone: 7200
),
                                          cod: "200",
                                          message: 0.0592709,
                                          cnt: 16,
                                          list: [List(dt: 1627038000,
                                                      sunrise: 1626235323,
                                                      sunset: 1626292228,
                                                      temp: Temp(day: 18.8, min: 14.75, max: 21.24, night: 18.19, eve: 20.74, morn: 15.19),
                                                      feelsLike: FeelsLike(day: 18.67, night: 18.1, eve: 20.62, morn: 15.25),
                                                      pressure: 1016,
                                                      humidity: 74,
                                                      weather: [Weather(id: 501, main: .rain, weatherDescription: "moderate rain", icon: "10d")],
                                                      speed: 6.09,
                                                      deg: 330,
                                                      gust: 11.29,
                                                      clouds: 98,
                                                      pop: 0.86,
                                                      rain: 5.96),
                                          ])

}
