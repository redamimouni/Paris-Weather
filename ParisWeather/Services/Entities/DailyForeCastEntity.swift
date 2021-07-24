//
//  DailyForeCastModel.swift
//  ParisWeather
//
//  Created by reda.mimouni on 14/07/2021.
//

import Foundation

// MARK: - Welcome
struct DailyForeCastEntity: Codable, Equatable {
    static func == (lhs: DailyForeCastEntity, rhs: DailyForeCastEntity) -> Bool {
        return lhs.city == rhs.city
            && lhs.cnt == rhs.cnt
            && lhs.cod == rhs.cod
            && lhs.message == rhs.message
            && lhs.list == rhs.list
    }
    
    let city: City
    let cod: String
    let message: Double
    let cnt: Int
    let list: [List]
}

// MARK: - City
struct City: Codable, Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.coord == rhs.coord
            && lhs.country == rhs.country
            && lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.population == rhs.population
    }
    
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone: Int
}

// MARK: - Coord
struct Coord: Codable, Equatable {
    let lon, lat: Double
}

// MARK: - List
struct List: Codable, Equatable {
    static func == (lhs: List, rhs: List) -> Bool {
        return lhs.clouds == rhs.clouds
            && lhs.deg == rhs.deg
            && lhs.dt == rhs.dt
            && lhs.feelsLike == rhs.feelsLike
            && lhs.gust == rhs.gust
            && lhs.humidity == rhs.humidity
            && lhs.pop == rhs.pop
            && lhs.rain == rhs.rain
            && lhs.weather == rhs.weather
            && lhs.pressure == rhs.pressure
            && lhs.speed == rhs.speed
            && lhs.sunset == rhs.sunset
            && lhs.sunrise == rhs.sunrise
    }
    
    let dt, sunrise, sunset: Int
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let weather: [Weather]
    let speed: Double
    let deg: Int
    let gust: Double
    let clouds: Int
    let pop: Double
    let rain: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity, weather, speed, deg, gust, clouds, pop, rain
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable, Equatable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable, Equatable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Weather
struct Weather: Codable, Equatable {
    let id: Int
    let main: Main
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum Main: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}
