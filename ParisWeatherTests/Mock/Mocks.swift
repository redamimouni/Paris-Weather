//
//  Mocks.swift
//  ParisWeatherTests
//
//  Created by reda.mimouni on 21/07/2021.
//

import Foundation
@testable import ParisWeather

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
                                          list: [List(dt: 1626260400,
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

extension ForecastListModel {
    static let mock = ForecastListModel(temperature: "19", day: "Wednesday")
}
